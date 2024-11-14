package.path = package.path .. ';../?.lua'

local extend = function(tables)
  local table = {}
  for _, v in ipairs(tables) do
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
  keys = {
    { '<leader>bf', '<cmd>lua vim.lsp.buf.format()<cr>',      mode = 'n', desc = 'Format current buffer', },
    { '<C-c>',      '<cmd>lua vim.lsp.buf.code_action()<cr>', mode = 'n', desc = 'Perform code action', },
    { '<leader>rn', '<cmd>lua vim.lsp.buf.rename()<cr>',      mode = 'n', desc = 'Rename symbol', },
  },
  event = 'BufEnter',
  config = function()
    vim.g.markdown_fenced_languages = {
      'ts=typescript',
    }

    require('mason').setup()
    require('mason-lspconfig').setup({
      ensure_installed = { 'lua_ls', },
      handlers = {
        function(server)
          server = (({
            tsserver = 'ts_ls',
          })[server]) or server

          local status, config = pcall(require, 'lsp.' .. server)
          if (not status) then config = {} end
          if (config.check ~= nil and not config.check()) then return end

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
