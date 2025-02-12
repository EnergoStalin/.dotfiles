local config = require('s21.sql.config')

local formatter_path = nil

local function formatter()
  if formatter_path then
    return formatter_path
  end
  formatter_path = vim.fs.joinpath(
    require('mason-registry').get_package('sql-formatter'):get_install_path(),
    'node_modules',
    '.bin',
    'sql-formatter'
  )
  return formatter_path
end

local function formatexpr(whole)
  local start = whole and 0 or (vim.v.lnum - 1)
  local _end = whole and -1 or (start + vim.v.count)

  local h = vim.system({ formatter(), '-l', 'postgresql', }, {
    clear_env = true,
    stdin = vim.api.nvim_buf_get_lines(0, start, _end, false),
    text = true,
  }):wait()

  if h.code ~= 0 then
    print(start, _end, h.stderr, h.stdout)
    return
  end

  vim.api.nvim_buf_set_lines(0, start, _end, false, vim.split(h.stdout, '\n'))
end

vim.api.nvim_set_option_value('formatexpr', 'v:lua.s21.sql:formatexpr()', { scope = 'global', })
vim.api.nvim_create_autocmd('BufWritePre', {
  callback = function() formatexpr(true) end,
  group = config.augroup,
  pattern = '*.sql',
})

return formatexpr
