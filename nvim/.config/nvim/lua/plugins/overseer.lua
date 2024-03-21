return {
  'stevearc/overseer.nvim',
  config = function()
    require('overseer').setup({})

    vim.keymap.set('n', '<leader>tt', '<cmd>OverseerToggle<cr>')
    vim.keymap.set('n', '<leader>tr', '<cmd>OverseerRun<cr>')
  end,
}
