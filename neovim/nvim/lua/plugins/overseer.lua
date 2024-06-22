return {
  'stevearc/overseer.nvim',
  config = function()
    require('overseer').setup({
      task_list = {
        direction = 'right',
        default_detail = 2,
      },
      templates = {
        'builtin',
        'user.AdbYandexBrowserOpen',
        'user.http',
      },
    })

    vim.keymap.set('n', '<leader>tt', '<cmd>OverseerToggle<cr>')
    vim.keymap.set('n', '<leader>ta', '<cmd>OverseerTaskAction<cr>')
    vim.keymap.set('n', '<leader>tr', '<cmd>OverseerRun<cr>')
  end,
}
