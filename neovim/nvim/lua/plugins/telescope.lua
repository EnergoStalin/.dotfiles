return {
  'nvim-telescope/telescope.nvim',
  dependencies = {
    'nvim-lua/plenary.nvim',
    'BurntSushi/ripgrep',
  },
  keys = {
    { '<leader>f',  '<cmd>Telescope find_files<cr>',            desc = 'Fuzzy find files respecting gitignore', },
    { '<leader>g',  '<cmd>Telescope live_grep<cr>',             desc = 'Fuzzy search for file content', },
    { '<leader>k',  '<cmd>Telescope keymaps<cr>',               desc = 'Fuzzy search keymaps', },
    { '<F1>',       '<cmd>Telescope lsp_workspace_symbols<cr>', desc = 'LSP workspace symbols', },
    { '<F2>',       '<cmd>Telescope lsp_references<cr>',        desc = 'LSP references', },
    { '<F3>',       '<cmd>Telescope lsp_implementations<cr>',   desc = 'LSP implementations', },
    { '<leader>c', '<cmd>Telescope git_bcommits_range<cr>',    mode = { 'x', 'o', },                           desc = 'Show commits referencing selected lines', },
  },
  config = true,
  opts = {
    pickers = {
      find_files = {
        hidden = true,
        prompt_prefix = '🔍',
      },
      live_grep = {
        hidden = true,
        prompt_prefix = '🗈 ',
      },
    },
    defaults = {
      file_ignore_patterns = {
        '.git/',
        'node_modules/',
        '.xmake/',
      },
    },
  },
}
