package.path = vim.fn.stdpath('config') .. '/?.lua;' .. package.path

require('options')
require('keybinds')
require('netrw')

-- File speficic actions
vim.cmd('source ' .. vim.fs.joinpath(vim.fn.stdpath('config'), 'files.vim'))

if vim.fn.getcwd():match('/opt/zapret') then
  require('zapret.nvim')
end

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

-- Requires overseer to be loaded
if vim.fn.getcwd():match('/s21/') then require('s21.nvim') end
