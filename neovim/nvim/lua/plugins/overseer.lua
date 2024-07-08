return {
  'stevearc/overseer.nvim',
  keys = {
    { '<leader>tt', '<cmd>OverseerToggle<cr>', mode = 'n', desc = 'Toggle overseer task view', },
    { '<C-t>', '<cmd>OverseerTaskAction<cr>', mode = 'n', desc = 'Perform action on task', },
    { '<C-x>', '<cmd>OverseerRun<cr>', mode = 'n', desc = 'Run overseer template', },
  },
  config = true,
  opts = {
    task_list = {
      direction = 'right',
      default_detail = 2,
    },
    templates = {
      'builtin',
      'user.AdbYandexBrowserOpen',
      'user.http',
    },
  },
}
