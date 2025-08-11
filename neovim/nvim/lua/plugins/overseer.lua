return {
  'stevearc/overseer.nvim',
  config = true,
  keys = {
    { '<leader>r', '<cmd>OverseerRun<cr>',        mode = { 'n', }, desc = 'Run overseer task', },
    { '<leader><cr>', '<cmd>OverseerTaskAction<cr>', mode = { 'n', }, desc = 'Perform overseer task action', },
  },
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