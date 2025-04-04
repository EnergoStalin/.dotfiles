vim.opt.mouse          = ''

vim.g.mapleader        = ' '
vim.g.maplocalleader   = ' '

vim.opt.backup         = false
vim.opt.writebackup    = false
vim.opt.updatetime     = 300
vim.opt.signcolumn     = 'yes'

vim.opt.tabstop        = 2
vim.opt.shiftwidth     = 2
vim.opt.wrap           = false

vim.opt.number         = true
vim.opt.expandtab      = true
vim.opt.relativenumber = true
vim.opt.splitright     = true
vim.opt.splitbelow     = true
vim.opt.cursorline     = true

vim.opt.list           = true
vim.opt.listchars      = 'eol:,lead:·,tab:⭾ '

vim.opt.autoread       = true
vim.opt.autoindent     = true

vim.opt.langmap        =
'ФИСВУАПРШОЛДЬТЩЗЙКЫЕГМЦЧНЯ;ABCDEFGHIJKLMNOPQRSTUVWXYZ,фисвуапршолдьтщзйкыегмцчня;abcdefghijklmnopqrstuvwxyz'

if not vim.g.as_pager then
  vim.opt.exrc = true
end

vim.opt.foldenable = false
vim.opt.foldlevel  = 99
vim.opt.foldmethod = 'indent'

vim.api.nvim_create_autocmd('BufWritePost', {
  pattern = '.nvim.lua',
  command = 'source <afile>',
  group = vim.api.nvim_create_augroup('nvim_source', { clear = true }),
})

vim.api.nvim_create_autocmd('TermOpen', {
  pattern = '*',
  callback = function()
    if vim.bo.buftype ~= 'terminal' then return end

    vim.wo.number         = false
    vim.wo.relativenumber = false
  end,
  group = vim.api.nvim_create_augroup('term_open', { clear = true })
})

if vim.fn.getcwd():match('/Dostup/') then
  vim.env.GIT_CONFIG_GLOBAL = vim.env.HOME .. '/Source/Dostup/.gitconfig'
end