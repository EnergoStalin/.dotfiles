local function find_lines(lines, match)
  local l = {}
  for _, line in pairs(lines) do
    if line:match(match) then table.insert(l, line) end
  end
  return l
end

local youtubeGVChanged = false
local youtubeGVChangeType = ""
local zapret = vim.api.nvim_create_augroup('zapret', { clear = true, })
vim.api.nvim_create_autocmd({ 'BufWritePre', }, {
  group = zapret,
  pattern = 'config',
  callback = function()
    local l1 = find_lines(
      vim.api.nvim_buf_get_lines(vim.api.nvim_get_current_buf(), 0, -1, false),
      'youtubeGV.txt'
    )
    local l2 = find_lines(
      vim.fn.readfile(vim.fn.expand('<afile>')),
      'youtubeGV.txt'
    )

    youtubeGVChanged = false
    youtubeGVChangeType = ""
    for i = 1, #l1 do
      local changed = l1[i] ~= l2[i]
      if changed then
        youtubeGVChangeType = youtubeGVChangeType .. (#youtubeGVChangeType == 0 and '' or ' ') .. l1[i]:gmatch([[$(%S+) ]])()
      end
      youtubeGVChanged = youtubeGVChanged or changed
    end
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

local ggc_test = nil
local googlevideo = vim.api.nvim_create_augroup('googlevideo', { clear = true, })
vim.api.nvim_create_autocmd({ 'BufWritePost', }, {
  group = googlevideo,
  pattern = 'config',
  callback = function()
    if not youtubeGVChanged then return end
    if ggc_test then
      ggc_test:kill()
    end

    notify('GGC "' .. youtubeGVChangeType .. '" test is running...')

    local output = ''
    local pipe = vim.uv.new_pipe(false)
    ggc_test = vim.uv.spawn('sh', {
        args = { '-c', 'source ./butils.sh; GGC_TEST_PROTO="' .. youtubeGVChangeType .. '" ggc_curl_test "$GGCS_TXT"', },
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
