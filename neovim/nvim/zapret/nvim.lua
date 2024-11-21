-- Basic settings
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.expandtab = true
vim.opt.shiftwidth = 2
vim.opt.tabstop = 2

vim.api.nvim_set_hl(0, 'Normal', { bg = 'NONE', ctermbg = 'NONE', })

local function find_line(lines, match)
  for _, line in pairs(lines) do
    if line:match(match) then return line end
  end
end

local youtubeGVChanged = false
local zapret = vim.api.nvim_create_augroup('zapret', { clear = true, })
vim.api.nvim_create_autocmd({ 'BufWritePre', }, {
  group = zapret,
  pattern = 'config',
  callback = function()
    local l1 = find_line(
      vim.api.nvim_buf_get_lines(vim.api.nvim_get_current_buf(), 0, -1, false),
      'youtubeGV.txt'
    )
    local l2 = find_line(
      vim.fn.readfile(vim.fn.expand('<afile>')),
      'youtubeGV.txt'
    )

    youtubeGVChanged = l1 ~= l2
  end,
})
vim.api.nvim_create_autocmd({ 'BufWritePre', }, {
  group = zapret,
  pattern = 'config',
  command = 'silent !systemctl stop zapret.service',
})
vim.api.nvim_create_autocmd({ 'BufWritePost', }, {
  group = zapret,
  pattern = 'config',
  command = 'silent !systemctl start zapret.service',
})
vim.api.nvim_create_autocmd('BufRead', {
  group = zapret,
  pattern = 'config',
  callback = function ()
    vim.bo.filetype = 'sh'
    vim.keymap.set('n', 'gf', function()
      local word = vim.fn.expand('<cWORD>')
      local prefix, fname = word:match('$([^/]+)/([^/]+)')
      if prefix == 'LIST' or prefix == 'IPSET' then
        vim.cmd('edit /opt/zapret/ipset/' .. fname)
      end
    end, { noremap = true, silent = true, buffer = true })
  end,
})

local notify = vim.schedule_wrap(function(msg)
  vim.notify(msg)
end)

local googlevideo = vim.api.nvim_create_augroup('googlevideo', { clear = true, })
local ggc_test = nil
vim.api.nvim_create_autocmd({ 'BufWritePost', }, {
  group = googlevideo,
  pattern = 'config',
  callback = function()
    if not youtubeGVChanged then return end
    if ggc_test then
      ggc_test:kill()
    end

    notify('GGC test is running...')

    local output = ''
    local pipe = vim.uv.new_pipe(false)
    ggc_test = vim.uv.spawn('sh', {
        args = { '-c', 'source ./butils.sh; ggc_curl_test "$GGCS_TXT"', },
        cwd = string.format('%s/%s', vim.fn.stdpath('config'), 'zapret'),
        stdio = { nil, pipe, nil, },
      },
      function(_, signal)
        ggc_test = nil
        if signal == 15 then -- sigterm
          return
        end
        notify(output)
      end
    )

    pipe:read_start(function(_, chunk)
      if chunk then output = output .. chunk end
    end)
  end,
})

vim.api.nvim_create_augroup('source', { clear = true, })
vim.api.nvim_create_autocmd({ 'BufWritePost', }, {
  group = 'source',
  pattern = '.nvim.lua',
  command = 'source <afile>',
})

-- Key mappings
vim.keymap.set('n', '\\k', ':!systemctl stop zapret.service<CR>', { noremap = true, silent = true, })
vim.keymap.set('n', '\\s', function()
  local buf = vim.api.nvim_create_buf(true, true)
  vim.api.nvim_buf_set_name(buf, 'zapret.service')
  vim.api.nvim_set_current_buf(buf)
  local stdout = vim.uv.new_pipe()

  vim.uv.spawn('systemctl', {
      args = { 'status', 'zapret.service', },
      stdio = { nil, stdout, nil, },
    },
    vim.schedule_wrap(function()
      vim.api.nvim_set_option_value('modified', false, { scope = 'local', buf = buf, })
      vim.api.nvim_set_option_value('modifiable', false, { scope = 'local', buf = buf, })
    end)
  )

  stdout:read_start(vim.schedule_wrap(function(_, data)
    if data then
      vim.api.nvim_buf_set_lines(buf, -1, -1, false, vim.split(data, '\n', { plain = true, }))
    end
  end))
end, { noremap = true, silent = true, })
