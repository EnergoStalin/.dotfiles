return {
  'kdheepak/lazygit.nvim',
  dependencies = {
    'nvim-lua/plenary.nvim',
  },
  config = function ()
    vim.g.lazygit_floating_window_scaling_factor = 1
  end,
  keys = {
    {
      '<leader>lg',
      '<cmd>LazyGit<cr>',
      desc = 'Open LazyGit floating window',
    },
  },
}
