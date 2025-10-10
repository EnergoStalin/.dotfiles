vim.lsp.inlay_hint.enable()

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