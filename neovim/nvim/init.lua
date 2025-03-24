local confpath = vim.fn.stdpath('config')

package.path = string.format('%s/?.lua;%s', confpath, package.path)

require('options')
require('keybinds')
require('netrw')

local lazypath = vim.fn.stdpath('data') .. '/lazy/lazy.nvim'
---@diagnostic disable-next-line: undefined-field
if not vim.loop.fs_stat(lazypath) then
	vim.fn.system({
		'git',
		'clone',
		'--filter=blob:none',
		'https://github.com/folke/lazy.nvim.git',
		'--branch=stable',
		lazypath,
	})
end
vim.opt.rtp:prepend(lazypath)

local lazy = require('lazy')

-- If used as pager(nvim --cmd 'lua vim.g.as_pager = 1') skip all plugins except theme
if
	vim.g.as_pager
then
	require('pager')(lazy)
end

-- File speficic actions
vim.cmd('source ' .. vim.fs.joinpath(confpath, 'files.vim'))

local function iszapret(s) return s:match('/opt/zapret') end
if
		iszapret(vim.fn.getcwd()) or
		iszapret(vim.fn.expand('%:p'))
then
	require('zapret.nvim')
end

return lazy.setup('plugins', {})