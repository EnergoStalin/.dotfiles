---@type vim.lsp.Config
return {
  root_markers = { '.venv' },
  root_dir = function(_, on_dir)
    local cwd = vim.fn.getcwd()
    if vim.system({
          'grep',
          '--include', '*.py',
          '--exclude-dir', '.venv',
          '--exclude-dir', '.git',
          '-Rm', '1', '.',
          '-e', 'django'
        }):wait().code ~= 0 then
      on_dir(cwd)
    end
  end,
  settings = {
    basedpyright = {
      analysis = {
        diagnosticMode = 'workspace',
        inlayHints = {
          callArgumentNames = true
        }
      }
    }
  }
}