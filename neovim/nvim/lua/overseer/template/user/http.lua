return {
  name = 'http',
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
    }
  },
  builder = function(opts)
    return {
      name = 'serving ' .. opts.path,
      cmd = {
        'python', '-m', 'http.server', '-b', opts.address, '-d', vim.fn.fnamemodify(opts.path, ':h'), opts.port
      },
      cwd = opts.cwd,
      components = {
        'default',
        'unique',
      }
    }
  end
}
