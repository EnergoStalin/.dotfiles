return {
  'williamboman/mason-lspconfig.nvim',
  dependencies = {
    'williamboman/mason.nvim',
    'neovim/nvim-lspconfig',
    'hrsh7th/nvim-cmp',
  },
  keys = {
    { 'glr',       '<cmd>LspRestart<cr>',               mode = 'n', desc = 'Rename symbol', },
    { 'gli',       '<cmd>LspInfo<cr>',                  mode = 'n', desc = 'Lsp info', },
    { 'gls',       '<cmd>LspStop<cr>',                  mode = 'n', desc = 'Lsp stop', },
    { 'gll',       '<cmd>LspLog<cr>',                   mode = 'n', desc = 'Lsp log', },
    { '<leader>M', '<cmd>Mason<cr>',                    mode = 'n', desc = 'Mason', },
  },
  event = 'FileType',
  config = function()
    vim.g.markdown_fenced_languages = {
      'ts=typescript',
    }

    local capabilities = vim.list_extend({}, vim.lsp.protocol.make_client_capabilities())
    capabilities = vim.list_extend(capabilities, require('cmp_nvim_lsp').default_capabilities())
    vim.lsp.config('*', {
      capabilities,
    })

    require('mason').setup()
    require('mason-lspconfig').setup({
      ensure_installed = { 'lua_ls', },
    })
  end,
}