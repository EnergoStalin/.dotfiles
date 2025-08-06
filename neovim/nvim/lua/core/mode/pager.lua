if not vim.g.as_pager then return false end

require('lazy').setup({
  spec = {
    {
      -- Support for ansi codes in output
      'm00qek/baleia.nvim',
      version = '*',
      config = function()
        local baleia = require('baleia').setup({})
        vim.api.nvim_create_autocmd('BufWinEnter', {
          callback = function(a) baleia.once(a.buf) end,
          group = vim.api.nvim_create_augroup('baleia', { clear = true, })
        })
      end,
    },
    { import = 'plugins.tokyonight-theme' },
  }
})

return true