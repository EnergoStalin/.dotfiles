local config = {
  single_file_support = false,
  root_markers = { 'tsconfig.json', 'jsconfig.json', 'package.json' },
}

-- if vim.fn.executable('tsgo') and not vim.fn.getcwd():match('/Vencord/?') then
--   config.cmd = { 'tsgo', 'lsp', '--stdio', }
-- end

return config