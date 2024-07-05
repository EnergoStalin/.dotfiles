return {
  'stevearc/overseer.nvim',
  keys = {
    { '<C-t>', '<cmd>OverseerToggle<cr>', mode = 'n', desc = 'Toggle overseer task view', },
    { '<C-x>', '<cmd>OverseerTaskAction<cr>', mode = 'n', desc = 'Perform action on last overseer task', },
    { '<C-h>', '<cmd>OverseerRun<cr>', mode = 'n', desc = 'Run overseer template', },
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
