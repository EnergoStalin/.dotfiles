---@type vim.lsp.Config
return {
  root_markers = { '.venv' },
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