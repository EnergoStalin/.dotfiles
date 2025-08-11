local notify = vim.schedule_wrap(function(...) vim.notify(...) end)
local plugin_dir = vim.fs.joinpath(vim.fn.stdpath('config'), 'lua', 'core', 'mode', 'zapret')

local function find_lines(lines, match)
  local l = {}
  for _, line in pairs(lines) do
    if line:match(match) then table.insert(l, line) end
  end
  return l
end

local function is_zapret_running()
  return vim.system({'systemctl', 'show', '-P', 'SubState', 'zapret.service'}):wait().stdout == 'running\n'
end

local show_buffer = vim.schedule_wrap(function (title, text)
  local buf = vim.api.nvim_create_buf(false, true)
  vim.api.nvim_buf_set_name(buf, title)
  vim.api.nvim_buf_set_lines(buf, 0, -1, false, vim.split(text, '\n', { trimempty = true, plain = true }))
  vim.api.nvim_create_autocmd('BufLeave', {
    buffer = buf,
    callback = function (args)
      vim.api.nvim_win_close(vim.api.nvim_get_current_win(), true)
      vim.api.nvim_buf_delete(args.buf, { force = true })
    end
  })
  vim.api.nvim_open_win(buf, true, { split = "below" })
  vim.api.nvim_set_current_buf(buf)
end)

local GVT = {
  config = {
    state = {
      types = {},
    },
  },
  handle = nil,
}

function GVT.config.state:reset()
  self.types = {}
  return self
end

function GVT:kill()
  if self.handle then
    notify('Killing previous execution', vim.log.levels.WARN)
    self.handle:kill(15)
    self.handle:wait()
  end
end

---@param line string
---@return string
local function parsetype(line)
  return line:gmatch([[$(%S+) ]])()
end

vim.api.nvim_create_autocmd('BufWritePre', {
  pattern = 'nfqws',
  callback = function(args)
    local l1 = find_lines(
      vim.api.nvim_buf_get_lines(0, 0, -1, false),
      'youtubeGV.txt'
    )
    local l2 = find_lines(
      vim.fn.readfile(args.file),
      'youtubeGV.txt'
    )

    local state = GVT.config.state:reset()

    local line = vim.fn.getline('.')
    local type = parsetype(line)
    if type then -- Always test for current line type
      state.types[type] = true
    end

    for i = 1, #l1 do
      local changed = l1[i] ~= l2[i]
      if changed then
        type = parsetype(l1[i])
        if type then state.types[type] = true end
      end
    end
  end,
})

vim.api.nvim_create_autocmd('BufWritePre', {
  pattern = 'nfqws',
  callback = function ()
    GVT:kill()
    vim.cmd('silent !sudo systemctl stop zapret.service')
  end
})

vim.api.nvim_create_autocmd('BufWritePost', {
  pattern = 'nfqws',
  command = 'silent !sudo systemctl start zapret.service',
})

vim.api.nvim_create_autocmd('BufEnter', {
  pattern = 'nfqws',
  callback = function()
    vim.bo.filetype = 'sh'
    vim.bo.path = vim.fn.join({vim.bo.path, '/opt/zapret/ipset'}, ',')
    vim.o.isfname = vim.o.isfname:gsub('/,', '')
  end,
})

vim.api.nvim_create_autocmd('BufWritePost', {
  pattern = 'nfqws',
  callback = function()
    local types = GVT.config.state.types
    if next(types) == nil then return end

    if not vim.wait(1000, is_zapret_running, 200) then notify('zapret is not running aborting test') return end

    local type = vim.fn.join(vim.tbl_keys(types), ' ')
    local prefix = 'GGC "' .. type .. '" test'

    notify(prefix .. ' is running...')

    GVT.handle = vim.system({
      'sh', '-c', 'source ./butils.sh; GGC_TEST_PROTO="' .. type .. '" ggc_curl_test "$GGCS_TXT"',
    }, {
      cwd = plugin_dir,
    }, function(out)
      GVT.handle = nil
      -- Print nothing on sigterm
      if out.signal == 15 then return end
      show_buffer(prefix .. ' results', out.stdout)
    end)
  end,
})

vim.keymap.set('n', '\\k', ':!sudo systemctl stop zapret.service<cr>', { noremap = true, silent = true, })
vim.keymap.set('n', '\\s', function()
  vim.cmd([[
    new zapret.service
    silent r!systemctl status zapret.service
    setlocal nomodified nomodifiable
    augroup zapret_service
      au! | au BufLeave <buffer> bd!
    augroup END
  ]])
end, { noremap = true, silent = true, })