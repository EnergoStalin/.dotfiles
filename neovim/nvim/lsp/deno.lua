local util = require 'lspconfig.util'

return {
  enable = true,
  root_dir = util.root_pattern('deno.json')
}
