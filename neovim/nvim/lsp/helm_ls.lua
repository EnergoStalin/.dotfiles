vim.filetype.add({
  pattern = {
    ['.*/templates/.*%.yaml'] = 'helm',
    ['Chart.yaml'] = 'helm',
    ['Values.yaml'] = 'helm'
  }
})

vim.treesitter.language.register('helm', { 'helm' })

return {
  root_markers = { 'Chart.yaml' },
  filetypes = { 'helm' },
  settings = {
    helmLint = {
      enabled = true,
    },
    yamlls = {
      enabled = true,
    }
  }
}