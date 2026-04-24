return {
  'stevearc/conform.nvim',
  keys = {
    { '<leader>b', '<cmd>lua require("conform").format()<cr>', mode = 'n', desc = 'Format current buffer', },
  },
  opts = {
    default_format_opts = {
      lsp_format = 'fallback',
    },
    formatters_by_ft = {
      ['_'] = { 'trim_whitespace' },
      python = { 'ruff_format', 'ruff_fix', 'ruff_organize_imports' },
      rust = { 'rustfmt', lsp_format = 'fallback' },
      lua = { lsp_format = 'fallback' },
    }
  }
}