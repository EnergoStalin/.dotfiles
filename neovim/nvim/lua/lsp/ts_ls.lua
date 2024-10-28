local util = require 'lspconfig.util'

return {
  single_file_support = false,
  root_dir = util.root_pattern('tsconfig.json', 'jsconfig.json', 'package.json')
}
