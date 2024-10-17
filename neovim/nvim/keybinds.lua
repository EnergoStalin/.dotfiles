vim.keymap.set('n', '<leader>,d', '<cmd>bp<bar>sp<bar>bn<bar>bd<CR>')
vim.keymap.set('n', '<C-n>', '<cmd>bn<CR>')
vim.keymap.set('n', '<C-p>', '<cmd>bp<CR>')

vim.cmd[[cnoreabbrev w!! :execute ':silent write !pkexec --keep-cwd tee % > /dev/null' | :edit!]]
