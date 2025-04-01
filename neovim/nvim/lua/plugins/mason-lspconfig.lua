package.path = package.path .. ';../?.lua'

return {
  'williamboman/mason-lspconfig.nvim',
  dependencies = {
    'williamboman/mason.nvim',
    'neovim/nvim-lspconfig',
    'hrsh7th/nvim-cmp',
  },
  keys = {
    { '<leader>b', '<cmd>lua vim.lsp.buf.format()<cr>', mode = 'n', desc = 'Format current buffer', },
    { 'glr',       '<cmd>LspRestart<cr>',               mode = 'n', desc = 'Rename symbol', },
    { 'gli',       '<cmd>LspInfo<cr>',                  mode = 'n', desc = 'Lsp info', },
    { 'gls',       '<cmd>LspStop<cr>',                  mode = 'n', desc = 'Lsp stop', },
  },
  event = 'FileType',
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
          if not status then config = {} end
          if (config.check ~= nil and not config.check()) then return end

          require('lspconfig')[server].setup(
            vim.tbl_deep_extend('force', config, {
              capabilities = {
                unpack(require('cmp_nvim_lsp').default_capabilities()),
              },
            })
          )
        end,
      },
    })
  end,
}