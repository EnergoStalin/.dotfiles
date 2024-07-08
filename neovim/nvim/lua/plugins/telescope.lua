return {
  'nvim-telescope/telescope.nvim',
  dependencies = {
    'nvim-lua/plenary.nvim',
    'BurntSushi/ripgrep',
  },
  keys = {
    { '<leader>ff', '<cmd>Telescope find_files<cr>',         desc = 'Fuzzy find files respecting gitignore', },
    { '<leader>fg', '<cmd>Telescope live_grep<cr>',          desc = 'Fuzzy search for file content', },
    { '<leader>fk', '<cmd>Telescope keymaps<cr>',            desc = 'Fuzzy search keymaps', },
    { '<F4>',       '<cmd>Telescope treesitter<cr>',         desc = 'Show incoming calls', },
    { '<F12>',      '<cmd>Telescope lsp_incoming_calls<cr>', desc = 'Show incoming calls', },
    { '<F11>',      '<cmd>Telescope lsp_outgoing_calls<cr>', desc = 'Show outgoing calls', },
    { '<F8>',       '<cmd>Telescope lsp_references<cr>',     desc = 'Show references', },
    { '<leader>gs', '<cmd>Telescope git_bcommits_range<cr>', mode = { 'x', 'o', },                           desc = 'Show commits referencing selected lines', },
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
