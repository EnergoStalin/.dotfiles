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

-- Allow reading per directory .nvim.lua files
vim.opt.exrc = true

vim.opt.foldenable = false
vim.opt.foldlevel = 99
vim.opt.foldmethod = 'indent'

vim.keymap.set('n', '<leader>e', '<cmd>Ex<cr>')

vim.keymap.set('n', '<leader>dn', '<cmd>lua vim.diagnostic.goto_next()<cr>')
vim.keymap.set('n', '<leader>dp', '<cmd>lua vim.diagnostic.goto_prev()<cr>')
vim.keymap.set('n', '<leader>q', '<cmd>lua vim.diagnostic.setloclist()<cr>')

vim.keymap.set('n', '<leader>bd', '<cmd>bd<cr>')

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
