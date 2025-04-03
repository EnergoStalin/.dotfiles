vim.keymap.set('n', '<leader>d', '<cmd>bp<bar>sp<bar>bn<bar>bd<cr>zz')
vim.keymap.set('n', '<leader>h', '<cmd>nohl<cr>')

-- Backport some neovim 11 default mappings
vim.keymap.set('n', ']q', '<cmd>cn<cr>')
vim.keymap.set('n', '[q', '<cmd>cp<cr>')
vim.keymap.set('n', ']b', '<cmd>bn<cr>')
vim.keymap.set('n', '[b', '<cmd>bp<cr>')

vim.keymap.set('n', '<leader>c', function()
  if vim.fn.expand('%:p:h') == vim.fn.getcwd() then
    vim.cmd('cd -')
  else
    vim.cmd('cd %:h')
  end
end)