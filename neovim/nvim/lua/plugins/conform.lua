return {
  'stevearc/conform.nvim',
  keys = {
    { '<leader>b', '<cmd>lua require("conform").format()<cr>', mode = 'n', desc = 'Format current buffer', },
  },
  opts = {
    default_format_opts = {
      lsp_format = "fallback",
    },
    formatters_by_ft = {
      ["_"] = { "trim_whitespace" },
      python = { "isort", "black" }
    }
  }
}