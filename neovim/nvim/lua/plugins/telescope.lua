return {
  'nvim-telescope/telescope.nvim',
  dependencies = {
    'nvim-lua/plenary.nvim',
    'BurntSushi/ripgrep',
  },
  keys = {
    { '<leader>ff', '<cmd>Telescope find_files<cr>', desc = 'Fuzzy find files respecting gitignore', },
    { '<leader>fg', '<cmd>Telescope live_grep<cr>',  desc = 'Fuzzy search for file content', },
    { '<leader>fk', '<cmd>Telescope keymaps<cr>',    desc = 'Fuzzy search keymaps', },
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
