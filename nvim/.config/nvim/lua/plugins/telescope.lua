return {
  'nvim-telescope/telescope.nvim',
  dependencies = {
    'nvim-lua/plenary.nvim',
    'BurntSushi/ripgrep',
  },
  keys = {
    { '<leader>ff', '<cmd>Telescope find_files hidden=True<cr>', desc = '', },
    { '<leader>fg', '<cmd>Telescope live_grep hidden=True<cr>',  desc = '', },
    { '<leader>fb', '<cmd>Telescope buffers hidden=True<cr>',    desc = '', },
  },
  config = function()
    require('telescope').setup({
      pickers = {
        find_files = {
          hidden = true,
        },
      },
      defaults = {
        file_ignore_patterns = {
          '.git/',
          'node_modules/',
          '.xmake/',
        },
      },
    })
  end,
}
