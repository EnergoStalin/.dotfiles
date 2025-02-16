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
      preview = true,
    },
    sql = {
      format = true,
    },
  },
}
