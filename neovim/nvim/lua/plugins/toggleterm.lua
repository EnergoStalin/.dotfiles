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
    local Terminal = require('toggleterm.terminal').Terminal

    function _G.set_terminal_keymaps()
      local opts = { buffer = 0, }
      vim.keymap.set('t', '<esc>', [[<C-\><C-n>]], opts)
    end

    -- if you only want these mappings for toggle term use term://*toggleterm#* instead
    vim.cmd('autocmd! TermOpen term://* lua set_terminal_keymaps()')
  end,
}
