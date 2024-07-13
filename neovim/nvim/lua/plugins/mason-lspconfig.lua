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
    { '<leader>bf',  '<cmd>lua vim.lsp.buf.format()<cr>',                   desc = 'Format current buffer', },
    { '<C-a>',       '<cmd>lua vim.lsp.buf.code_action()<cr>',              desc = 'Perform code action', },
    { '<leader>rn',  '<cmd>lua vim.lsp.buf.rename()<cr>',                   desc = 'Rename symbol', },

    { '<leader>lsi', '<cmd>LspInfo<cr>',                                    desc = 'LSP info', },
    { '<leader>lsr', '<cmd>LspRestart<cr>',                                 desc = 'LSP restart', },
  },
  event = 'BufEnter',
  config = function()
    require('mason').setup()
    require('mason-lspconfig').setup({
      ensure_installed = { 'lua_ls', },
      handlers = {
        function(server)
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
