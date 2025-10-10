return {
  dir = '~/Source/s21toolkit/s21.nvim',
  event = 'VeryLazy',
  dependencies = {
    'stevearc/overseer.nvim',
    'williamboman/mason.nvim',
  },
  keys = {
    { '<leader>;', '<cmd>S21GitlabOpen<cr>', mode = { 'n', }, },
  },
  cond = function() return vim.fn.getcwd():match('/s21/') ~= nil end,
  opts = {
    switch = true,
    task = {
      preview = function()
        local api = require('s21.api')
        if not api.window_title_contains('README.*%.md', { plain = false }) then
          vim.system({ 'sh', '-c', 'chromium --new-window file://$(find "' ..
          vim.fs.joinpath(api:project_root(), '" -type f -name "README*.md" -print -quit)'), })
        end
      end,
    },
    sql = {
      format = true,
    },
  },
}