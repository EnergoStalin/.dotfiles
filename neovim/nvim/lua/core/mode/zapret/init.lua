local function iszapret(s) return s:match('/opt/zapret') end
if
    iszapret(vim.fn.getcwd()) or
    iszapret(vim.fn.expand('%:p'))
then
  require('core.mode.zapret.nvim')
end