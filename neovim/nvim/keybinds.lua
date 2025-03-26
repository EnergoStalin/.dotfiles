vim.keymap.set('n', '<leader>d', '<cmd>bp<bar>sp<bar>bn<bar>bd<cr>zz')
vim.keymap.set('n', '<leader>h', '<cmd>nohl<cr>')
vim.keymap.set('n', '<c-n>', '<cmd>bn<cr>')
vim.keymap.set('n', '<c-p>', '<cmd>bp<cr>')

vim.keymap.set('n', '<leader>c', function ()
	if vim.fn.expand('%:p:h') == vim.fn.getcwd() then
		vim.cmd('cd -')
	else
		vim.cmd('cd %:h')
	end
end)