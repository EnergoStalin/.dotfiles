return {
  'akinsho/toggleterm.nvim',
  keys = {
    { '<C-\\>', '<cmd>:ToggleTerm<cr>', mode = 'n', desc = 'Toggle terminal via well known plugin', },

    { '<C-\\>', '<cmd>:ToggleTerm<cr>', mode = 't', ft = 'toggleterm', },
    { '<esc>',  [[<C-\><C-n>]],         mode = 't', ft = 'toggleterm', },
  },
  opts = {
    direction = 'horizontal',
    size = function()
      return vim.o.lines * 0.2
    end,
  },
  config = true,
}
