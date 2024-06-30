local w = function(s, c)
  local o = c or {}
  return vim.tbl_deep_extend('force', {
    s,
    dependencies = {
      'neovim/nvim-lspconfig',
      'L3MON4D3/LuaSnip',
    },
  }, o)
end

return {
  {
    'L3MON4D3/LuaSnip',
    version = 'v2.*',
    build = 'make install_jsregexp',
    config = function()
      local ls = require('luasnip')

      vim.keymap.set({ 'i', }, '<C-K>', function() ls.expand() end, { silent = true, desc = 'LuaSnip expand' })
      vim.keymap.set({ 'i', 's', }, '<C-L>', function() ls.jump(1) end, { silent = true, desc = 'LuaSnip next' })
      vim.keymap.set({ 'i', 's', }, '<C-J>', function() ls.jump(-1) end, { silent = true, desc = 'LuaSnip previous' })

      vim.keymap.set({ 'i', 's', }, '<C-E>', function()
        if ls.choice_active() then
          ls.change_choice(1)
        end
      end, { silent = true, desc = 'LuaSnip choose' })
    end,
  },

  w('hrsh7th/cmp-nvim-lsp'),
  w('hrsh7th/cmp-buffer', { lazy = false, }),

  w('hrsh7th/nvim-cmp', {
    config = function()
      local cmp = require('cmp')

      cmp.setup({
        snippet = {
          expand = function(args)
            require('luasnip').lsp_expand(args.body)
          end,
        },
        sources = cmp.config.sources({
          { name = 'nvim_lsp', },
        }, {
          { name = 'buffer', },
        }),
        mapping = cmp.mapping.preset.insert({
          ['<C-b>'] = cmp.mapping.scroll_docs(-4),
          ['<C-f>'] = cmp.mapping.scroll_docs(4),
          ['<C-Space>'] = cmp.mapping.complete(),
          ['<C-e>'] = cmp.mapping.abort(),
          ['<CR>'] = cmp.mapping.confirm({ select = true, }),
        }),
      })
    end,
  }),
}
