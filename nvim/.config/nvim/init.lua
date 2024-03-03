vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

vim.opt.tabstop = 2
vim.opt.shiftwidth = 2
vim.opt.scrolloff = 15

vim.opt.list = true
vim.opt.number = true
vim.opt.expandtab = true
vim.opt.relativenumber = true
vim.opt.splitbelow = true
vim.opt.listchars = 'eol:↵,lead:·,tab:⭾ '

vim.keymap.set('n', '<leader>e', '<cmd>Ex<cr>')

vim.keymap.set('n', '<leader>dn', '<cmd>lua vim.diagnostic.goto_next()<cr>')
vim.keymap.set('n', '<leader>dp', '<cmd>lua vim.diagnostic.goto_prev()<cr>')

vim.keymap.set('n', '<leader>bn', '<cmd>bn<cr>')
vim.keymap.set('n', '<leader>bp', '<cmd>bp<cr>')
vim.keymap.set('n', '<leader>bd', '<cmd>bd<cr>')
vim.keymap.set('n', '<leader>bl', '<cmd>ls<cr>')

local lazypath = vim.fn.stdpath('data') .. '/lazy/lazy.nvim'
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    'git',
    'clone',
    '--filter=blob:none',
    'https://github.com/folke/lazy.nvim.git',
    '--branch=stable', -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

require('lazy').setup('plugins', {})
