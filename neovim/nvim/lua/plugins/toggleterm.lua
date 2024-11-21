return
{
  'akinsho/toggleterm.nvim',
  version = '*',
  events = 'BufEnter',
  keys = {
    { '<leader>t', '<cmd>ToggleTerm<cr>', mode = { 'n', }, desc = 'Toggle terminal on the bootom' },
  },
  config = function()
    require('toggleterm').setup({
      direction = 'horizontal',
      size = function(term)
        if (term.direction == 'horizontal') then
          return 10
        elseif (term.direction == 'vertical') then
          return vim.o.columns * 0.4
        end
      end,
    })

    vim.api.nvim_create_autocmd("TermOpen", {
      pattern = "term://*",
      callback = function()
        vim.wo.number = false
        vim.wo.relativenumber = false

        local opts = { buffer = 0, }
        vim.keymap.set('t', '<esc>', [[<C-\><C-n>]], opts)
      end,
      group = vim.api.nvim_create_augroup("toggleterm", { clear = true })
    })
  end,
}
