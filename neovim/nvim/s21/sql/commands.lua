local ex = require('s21.sql.ex')

vim.api.nvim_create_user_command('S21OpenSqlTaskFile', function(args)
  local exnum = tonumber(args.args)
  if not exnum then
    vim.notify('Argument must be numeric', vim.log.levels.ERROR)
    return
  end

  ex.open(exnum)
end, { nargs = 1, })
