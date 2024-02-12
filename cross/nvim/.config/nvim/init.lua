vim.g.mapleader = " "
vim.g.maplocalleader = " "

vim.opt.tabstop = 2
vim.opt.shiftwidth = 2
vim.opt.scrolloff = 15

vim.opt.number = true
vim.opt.expandtab = true
vim.opt.relativenumber = true
vim.opt.listchars = "eol:$,tab:>-,trail:~,extends:>,precedes:<"

vim.keymap.set('n', '<leader>e', '<cmd>Ex<cr>')

vim.keymap.set('n', 'gn', '<cmd>bn<cr>')
vim.keymap.set('n', 'gp', '<cmd>bp<cr>')
vim.keymap.set('n', 'gd', '<cmd>bd<cr>')

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable",     -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup("plugins", {})
