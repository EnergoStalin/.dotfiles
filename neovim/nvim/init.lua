vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

vim.opt.tabstop = 2
vim.opt.shiftwidth = 2
vim.opt.scrolloff = 15

vim.opt.list = true
vim.opt.number = true
vim.opt.expandtab = true
vim.opt.relativenumber = true
vim.opt.splitright = true
vim.opt.cursorline = true
vim.opt.listchars = 'eol:↵,lead:·,tab:⭾ '

vim.opt.autoread = true
vim.opt.autoindent = true

vim.opt.langmap = 'ФИСВУАПРШОЛДЬТЩЗЙКЫЕГМЦЧНЯ;ABCDEFGHIJKLMNOPQRSTUVWXYZ,фисвуапршолдьтщзйкыегмцчня;abcdefghijklmnopqrstuvwxyz'

-- Allow reading per directory .nvim.lua files
vim.opt.exrc = true

vim.opt.foldenable = false
vim.opt.foldlevel = 99
vim.opt.foldmethod = 'indent'

vim.keymap.set('n', '<leader>q', '<cmd>lua vim.diagnostic.setloclist()<cr>', { desc = 'open diagnostic quickfix list' })

vim.keymap.set('n', '<C-e>', '<cmd>qa<CR>', { desc = 'quit neovim' })
vim.keymap.set('n', '<C-q>', '<cmd>bp<bar>sp<bar>bn<bar>bd<CR>', { desc = 'delete current buffer' })
vim.keymap.set('n', '<C-n>', '<cmd>bn<cr>', { desc = 'next buffer' })
vim.keymap.set('n', '<C-p>', '<cmd>bp<cr>', { desc = 'prefious buffer' })

-- Always resource .nvim.lua aftew writing
vim.cmd([[
  augroup nvim_source
    autocmd!
    autocmd BufWritePost .nvim.lua source <afile>
  augroup END
]])

local lazypath = vim.fn.stdpath('data') .. '/lazy/lazy.nvim'
---@diagnostic disable-next-line: undefined-field
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
