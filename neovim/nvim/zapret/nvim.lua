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

vim.api.nvim_create_autocmd({ 'BufWritePre', }, {
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
vim.api.nvim_create_autocmd({ 'BufWritePre', }, {
  pattern = 'config',
  command = 'silent !systemctl stop zapret.service',
})
vim.api.nvim_create_autocmd({ 'BufWritePost', }, {
  pattern = 'config',
  command = 'silent !systemctl start zapret.service',
})
vim.api.nvim_create_autocmd('BufEnter', {
  pattern = 'config',
  callback = function()
    vim.bo.filetype = 'sh'
    vim.keymap.set('n', 'gf', function()
      local word = vim.fn.expand('<cWORD>')
      local prefix, fname = word:match('$([^/]+)/([^/]+)')
      if prefix == 'LIST' or prefix == 'IPSET' then
        vim.cmd('edit /opt/zapret/ipset/' .. fname)
      end
    end, { noremap = true, silent = true, buffer = 0, })
  end,
})

local notify = vim.schedule_wrap(function(msg)
  vim.notify(msg)
end)

vim.api.nvim_create_autocmd({ 'BufWritePost', }, {
  pattern = 'config',
  callback = function()
    if not GVT.config.state.changed then return end
    if GVT.handle then
      GVT.handle:kill(15) -- sigterm
    end

    local types = vim.fn.join(GVT.config.state.types, ' ')

    notify('GGC "' .. types .. '" test is running...')

    GVT.handle = vim.system({ 'sh', '-c',
      'source ./butils.sh; GGC_TEST_PROTO="' .. types .. '" ggc_curl_test "$GGCS_TXT"',
    }, {
      cwd = string.format('%s/%s', vim.fn.stdpath('config'), 'zapret'),
    }, function(out)
      GVT.handle = nil
      if out.signal == 15 then -- sigterm
        return
      end
      notify(out.stdout)
    end)
  end,
})

vim.keymap.set('n', '\\k', ':!systemctl stop zapret.service<CR>', { noremap = true, silent = true, })
vim.keymap.set('n', '\\s', function()
  local buf = vim.api.nvim_create_buf(false, true)
  vim.api.nvim_buf_set_name(buf, 'zapret.service')
  vim.api.nvim_set_current_buf(buf)

  local h = vim.system({ 'systemctl', 'status', 'zapret.service', }, {}):wait()
  vim.api.nvim_buf_set_lines(buf, 0, -1, false, vim.split(h.stdout, '\n', { plain = true, }))
  vim.api.nvim_set_option_value('modifiable', false, { buf = buf, })

  vim.keymap.set('n', '<CR>', '<cmd>bd!<cr>', { buffer = buf, })
  vim.keymap.set('n', '<Esc>', '<cmd>bd!<cr>', { buffer = buf, })
  vim.api.nvim_create_autocmd('BufLeave', {
    buffer = buf,
    callback = function(args)
      vim.api.nvim_buf_delete(args.buf, { force = true, })
    end,
  })
end, { noremap = true, silent = true, })
