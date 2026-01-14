return {
  'folke/snacks.nvim',
  priority = 1000,
  lazy = false,
  opts = {
    bigfile = { enabled = true },
    input = { enabled = true },
    picker = { enabled = true },
    quickfile = { enabled = true },
    scope = { enabled = true, },
    styles = {
      lazygit = {
        width = 0.99,
        height = 0.99
      },
      terminal = {
        height = 0.99
      },
    },
  },
  keys = {
    { '<leader>n',  function() Snacks.notifier.show_history() end, desc = 'Notification History' },
    { '<leader>x',  function() Snacks.bufdelete() end,             desc = 'Delete Buffer' },
    { '<leader>cR', function() Snacks.rename.rename_file() end,    desc = 'Rename File' },
    { '<leader>lg', function() Snacks.lazygit() end,               desc = 'Lazygit' },
    { '<leader>t',  function() Snacks.terminal() end,              desc = 'Toggle Terminal' },
  }
}