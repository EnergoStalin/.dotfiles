return {
  name = 'http',
  hide = true,
  params = {
    path = {
      type = 'string',
      optional = false
    },
    port = {
      type = 'number',
      default = 8080,
      optional = true
    },
    address = {
      type = 'string',
      default = '127.0.0.1',
      optional = true
    },
    cwd = {
      type = 'string',
      optional = true
    },
    components = {
      name = 'components',
      type = 'table',
      default = {},
      optional = true,
      description = 'additional components to attach'
    },
  },
  builder = function(o)
    return {
      name = 'serving ' .. o.path,
      cmd = {
        'python', '-m', 'http.server', '-b', o.address, '-d', vim.fn.fnamemodify(o.path, ':h'), o.port
      },
      cwd = o.cwd,
      components = vim.tbl_extend('force', { 'default', 'unique', }, o.components)
    }
  end
}
