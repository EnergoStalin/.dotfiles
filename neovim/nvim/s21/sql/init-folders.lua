local overseer = require('overseer')
local config = require('s21.sql.config')

overseer.register_template({
  name = 'init folders',
  params = {
    count = {
      type = 'number',
      name = 'Task count',
    },
    day_number = {
      type = 'number',
      name = 'Day number',
    },
  },
  builder = function(p)
    return {
      name = 'init folders',
      cmd = { 'sh', vim.fs.joinpath(config.data_path, 'init.sh'), },
      env = { N = p.count, DN = p.day_number, },
      components = { 'default', 'unique', },
    }
  end,
})
