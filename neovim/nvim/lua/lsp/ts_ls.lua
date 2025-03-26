local util = require 'lspconfig.util'

local config = {
  single_file_support = false,
  root_dir = util.root_pattern('tsconfig.json', 'jsconfig.json', 'package.json'),
}

if vim.fn.executable('tsgo') and not vim.fn.getcwd():match('/Vencord/?') then
	config.cmd = { 'tsgo', 'lsp', '--stdio', }
end

return config