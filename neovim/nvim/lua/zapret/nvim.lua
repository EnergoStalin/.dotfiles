local function find_lines(lines, match)
  local l = {}
  for _, line in pairs(lines) do
    if line:match(match) then table.insert(l, line) end
  end
  return l
end

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
  command = 'silent !systemctl stop zapret.service',
})

vim.api.nvim_create_autocmd('BufWritePost', {
  pattern = 'nfqws',
  command = 'silent !systemctl start zapret.service',
})

vim.api.nvim_create_autocmd('BufEnter', {
  pattern = 'nfqws',
  callback = function()
    vim.bo.filetype = 'sh'
    vim.bo.path = vim.fn.join({vim.bo.path, '/opt/zapret/ipset'}, ',')
    vim.o.isfname = vim.o.isfname:gsub('/,', '')
  end,
})

local notify = vim.schedule_wrap(function(msg)
  vim.notify(msg)
end)

vim.api.nvim_create_autocmd('BufWritePost', {
  pattern = 'nfqws',
  callback = function()
    if next(GVT.config.state.types) == nil then return end
    if GVT.handle then
      GVT.handle:kill(15) -- sigterm
    end

    local types = vim.fn.join(vim.tbl_keys(GVT.config.state.types), ' ')

    notify('GGC "' .. types .. '" test is running...')

    GVT.handle = vim.system({
      'sh', '-c',
      string.format(
        'source ./butils.sh; GGC_TEST_PROTO="%s" ggc_curl_test "$GGCS_TXT"',
        types
      ),
    }, {
      cwd = vim.fs.joinpath(vim.fn.stdpath('config'), 'lua', 'zapret'),
    }, function(out)
      GVT.handle = nil
      -- Print nothing on sigterm
      if out.signal == 15 then return end
      notify(out.stdout)
    end)
  end,
})

vim.keymap.set('n', '\\k', ':!systemctl stop zapret.service<cr>', { noremap = true, silent = true, })
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