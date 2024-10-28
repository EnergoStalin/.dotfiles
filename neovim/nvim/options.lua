vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

vim.opt.backup = false
vim.opt.writebackup = false
vim.opt.updatetime = 300
vim.opt.signcolumn = "yes"

vim.opt.tabstop = 2
vim.opt.shiftwidth = 2

vim.opt.number = true
vim.opt.expandtab = true
vim.opt.relativenumber = true
vim.opt.splitright = true
vim.opt.cursorline = true

vim.opt.list = true
vim.opt.listchars = 'eol:↵,lead:·,tab:⭾ '

vim.opt.autoread = true
vim.opt.autoindent = true

vim.opt.langmap =
'ФИСВУАПРШОЛДЬТЩЗЙКЫЕГМЦЧНЯ;ABCDEFGHIJKLMNOPQRSTUVWXYZ,фисвуапршолдьтщзйкыегмцчня;abcdefghijklmnopqrstuvwxyz'

vim.opt.exrc = true

vim.opt.foldenable = false
vim.opt.foldlevel = 99
vim.opt.foldmethod = 'indent'

-- Always resource .nvim.lua after writing
vim.cmd([[
  augroup nvim_source
    autocmd!
    autocmd BufWritePost .nvim.lua source <afile>
  augroup END
]])
