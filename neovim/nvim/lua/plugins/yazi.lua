return {
  'mikavilpas/yazi.nvim',
  dependencies = {
    'nvim-lua/plenary.nvim',
  },
  keys = {
    -- 👇 in this section, choose your own keymappings!
    {
      '<leader>-',
      function()
        require('yazi').yazi()
      end,
      desc = 'Open the file manager',
    },
    {
      '<leader>e',
      function()
        require('yazi').yazi(nil, vim.fn.getcwd())
      end,
      desc = "Open the file manager in nvim's working directory",
    },
  },
  opts = {
    open_for_directories = false,
    floating_window_scaling_factor = 1,
    yazi_floating_window_border = 'none',
  },
}
