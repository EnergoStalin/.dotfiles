return {
  'nvim-telescope/telescope.nvim',
  dependencies = {
    'nvim-lua/plenary.nvim',
    'BurntSushi/ripgrep',
    'nvim-tree/nvim-web-devicons',
  },
  keys = {
    { '<leader>f', '<cmd>Telescope find_files<cr>',            desc = 'Fuzzy find files respecting gitignore',             },
    { '<leader>g', '<cmd>Telescope live_grep<cr>',             desc = 'Fuzzy search for file content',                     },
    { '<F1>',      '<cmd>Telescope lsp_workspace_symbols<cr>', desc = 'LSP workspace symbols',                             },
    { '<F2>',      '<cmd>Telescope lsp_references<cr>',        desc = 'LSP references',                                    },
    { '<F3>',      '<cmd>Telescope lsp_implementations<cr>',   desc = 'LSP implementations',                               },
    { '<leader>k', '<cmd>Telescope grep_string<cr>',           desc = 'Search for selected word in the current directory', },

    { '<leader>c', '<cmd>Telescope git_bcommits_range<cr>', mode = { 'v', 'x', 'o', }, desc = 'Show commits referencing selected lines',           },
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
        prompt_prefix = '󱔗 ',
        smartcase = true,
      },
    },
    defaults = {
      file_ignore_patterns = {
        '.git/',
        'node_modules/',
        '.xmake/',
        '.venv/',
        '__pycache__/',
      },
    },
  },
}