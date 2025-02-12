local M = { }

local overseer = require('overseer')
local config = require('s21.sql.config')

local docker = {
  name = 'docker',
  hide = true,
  params = {
    op = {
      type = 'string',
      name = 'Operation',
      desc = 'Operation to execute on compose up/down',
      default = 'up',
    },
    flags = {
      type = 'list',
      desc = 'Additional flags to pass after command',
      optional = true,
      default = {},
    },
    components = {
      type = 'table',
      desc = 'Additional task components',
      optional = true,
      default = {},
    },
  },
  builder = function(p)
    local cwd = vim.fs.dirname(vim.fn.getcwd())
    local components = {
      'default',
      'unique',
      unpack(p.components),
    }
    local composefile = vim.fs.joinpath(config.data_path, 'docker-compose.yml')

    local task = {
      name = 'docker ' .. p.op,
      cmd = vim.list_extend({
        'docker', 'compose', '-f', composefile, p.op,
      }, p.flags),
      cwd = cwd,
      env = {
        PWD = cwd,
        POSTGRES_PASSWORD = config.postgres.password,
        POSTGRES_USER = config.postgres.user,
        POSTGRES_DB = config.postgres.db,
      },
      components = components,
    }

    return task
  end,
}

overseer.register_template(docker)

local docker_down = overseer.wrap_template(
  docker,
  { name = 'docker down', hide = false, },
  { op = 'down', flags = { '-v', '-t', '0', }, }
)
overseer.register_template(docker_down)

local docker_up = overseer.wrap_template(
  docker,
  { name = 'docker up', hide = false, },
  { op = 'up', components = { { 'dependencies', task_names = { 'docker down', }, }, }, }
)
overseer.register_template(docker_up)

return M
