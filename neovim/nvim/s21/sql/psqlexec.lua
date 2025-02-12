local config = require('s21.sql.config')

return function()
  if vim.api.nvim_buf_line_count(0) < 2 then
    vim.notify('Not executing no lines in current buffer', vim.log.levels.WARN)
    return
  end

  local h = vim.system({
      'psql',
      string.format(
        'postgresql://%s:%s@127.0.0.1:%d/%s',
        config.postgres.user,
        config.postgres.password,
        config.postgres.port,
        config.postgres.db
      ),
    },
    {
      env = { PAGER = 'cat', },
      stdin = vim.api.nvim_buf_get_lines(0, 0, -1, false),
    }):wait()

  if h.code ~= 0 then
    vim.notify(h.stderr, vim.log.levels.ERROR)
    return
  end

  local opts = { buffer = vim.api.nvim_create_buf(false, true), }
  vim.api.nvim_buf_set_lines(opts.buffer, 0, -1, false, vim.split(h.stdout, '\n'))
  vim.api.nvim_set_option_value('modifiable', false, { buf = opts.buffer, })

  vim.keymap.set('n', '<CR>', '<cmd>bd!<CR>', opts)
  vim.keymap.set('n', '<Esc>', '<cmd>bd!<CR>', opts)
  vim.keymap.set('n', '.', function() require('s21.sql.ex').advance(1, true) end, opts)
  vim.api.nvim_create_autocmd('BufLeave', {
    group = config.augroup,
    buffer = opts.buffer,
    callback = function(a)
      vim.api.nvim_buf_delete(a.buf, { force = true, })
    end,
  })

  vim.api.nvim_open_win(opts.buffer, true, {
    win = 0,
    split = 'below',
    height = math.floor(vim.api.nvim_win_get_height(0) * 0.9),
  })
end
