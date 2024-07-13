return {
  'akinsho/toggleterm.nvim',
  keys = {
    { '<C-\\>', '<cmd>:ToggleTerm<cr>', mode = 'n', desc = 'Toggle terminal via well known plugin', },

    { '<C-\\>', '<cmd>:ToggleTerm<cr>', mode = 't', ft = 'toggleterm', },
    { '<esc>',  [[<C-\><C-n>]],         mode = 't', ft = 'toggleterm', },
  },
  opts = {
    direction = 'vertical',
    size = function()
      return vim.o.columns * 0.4
    end,
  },
  config = true,
}
