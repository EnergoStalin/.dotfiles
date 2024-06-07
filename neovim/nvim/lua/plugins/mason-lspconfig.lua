package.path = package.path .. ';../?.lua'

local extend = function(tables)
  local table = {}
  for _, v in pairs(tables) do
    table = vim.tbl_deep_extend('force', table, v)
  end

  return table
end

return {
  'williamboman/mason-lspconfig.nvim',
  dependencies = {
    'williamboman/mason.nvim',
    'neovim/nvim-lspconfig',
  },
  config = function()
    require('mason').setup()
    require('mason-lspconfig').setup({
      ensure_installed = { 'lua_ls', },
      handlers = {
        function(server)
          local status, config = pcall(require, 'lsp.' .. server)
          if (not status) then config = {} end
          if (config.check ~= nil and not config.check()) then return end

          vim.keymap.set('n', '<leader>bf', '<cmd>lua vim.lsp.buf.format()<cr>')
          vim.keymap.set('n', '<C-a>', '<cmd>lua vim.lsp.buf.code_action()<cr>')
          vim.keymap.set('n', '<leader>rn', '<cmd>lua vim.lsp.buf.rename()<cr>')

          vim.keymap.set('n', '<leader>lse', '<cmd>LspStop<cr><cmd>lua vim.diagnostic.reset()<cr>')
          vim.keymap.set('n', '<leader>lsi', '<cmd>LspInfo<cr>')
          vim.keymap.set('n', '<leader>lsr', '<cmd>LspRestart<cr>')

          require('lspconfig')[server].setup(vim.tbl_deep_extend('force', config, {
            capabilities = extend({
              require('cmp_nvim_lsp').default_capabilities(),
            }),
          }))
        end,
      },
    })
  end,
}
