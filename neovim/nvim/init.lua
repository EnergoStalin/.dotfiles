-- Some things was easier to write in vimscript
vim.cmd('source ' .. vim.fs.joinpath(vim.fn.stdpath('config'), 'autocmds.vim'))

require('options')
require('core')