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
      changed = false,
      types = {},
    },
  },
  handle = nil,
}

function GVT.config.state:reset()
  self.changed = false
  self.types = {}
end

vim.api.nvim_create_autocmd('BufWritePre', {
  pattern = 'config',
  callback = function(args)
    local l1 = find_lines(
      vim.api.nvim_buf_get_lines(0, 0, -1, false),
      'youtubeGV.txt'
    )
    local l2 = find_lines(
      vim.fn.readfile(args.file),
      'youtubeGV.txt'
    )

    local state = GVT.config.state

    state:reset()
    for i = 1, #l1 do
      local changed = l1[i] ~= l2[i]
      if changed then
        table.insert(state.types, l1[i]:gmatch([[$(%S+) ]])())
      end
      state.changed = state.changed or changed
    end
  end,
})

vim.api.nvim_create_autocmd('BufWritePre', {
  pattern = 'config',
  command = 'silent !systemctl stop zapret.service',
})

vim.api.nvim_create_autocmd('BufWritePost', {
  pattern = 'config',
  command = 'silent !systemctl start zapret.service',
})

vim.api.nvim_create_autocmd('BufEnter', {
  pattern = 'config',
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
  pattern = 'config',
  callback = function()
    if not GVT.config.state.changed then return end
    if GVT.handle then
      GVT.handle:kill(15) -- sigterm
    end

    local types = vim.fn.join(GVT.config.state.types, ' ')

    notify('GGC "' .. types .. '" test is running...')

    GVT.handle = vim.system({
      'sh', '-c',
      string.format(
        'source ./butils.sh; GGC_TEST_PROTO="%s" ggc_curl_test "$GGCS_TXT"',
        types
      ),
    }, {
      cwd = string.format('%s/%s', vim.fn.stdpath('config'), 'zapret'),
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
    setlocal nomodifiable nomodified
    nnoremap <buffer> <CR> :bd<CR>
    nnoremap <buffer> <Esc> :bd<CR>
    autocmd BufLeave <buffer> execute 'bd ' . bufnr('%')
  ]])
end, { noremap = true, silent = true, })