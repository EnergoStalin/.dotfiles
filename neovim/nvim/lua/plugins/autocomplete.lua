local luasnip = {
  'L3MON4D3/LuaSnip',
  version = 'v2.*',
  build = 'make install_jsregexp',
  event = 'BufEnter',
  config = function()
    local ls = require('luasnip')
    require('luasnip.loaders.from_lua').load({ paths = vim.fn.stdpath('config') .. '/lua/snippets', })
    vim.keymap.set({ 'i', }, '<C-K>', function() ls.expand() end, { silent = true, desc = 'LuaSnip expand', })
    vim.keymap.set({ 'i', 's', }, '<C-L>', function() ls.jump(1) end, { silent = true, desc = 'LuaSnip next', })
    vim.keymap.set({ 'i', 's', }, '<C-J>', function() ls.jump(-1) end, { silent = true, desc = 'LuaSnip previous', })

    vim.keymap.set({ 'i', 's', }, '<C-E>', function()
      if ls.choice_active() then
        ls.change_choice(1)
      end
    end, { silent = true, desc = 'LuaSnip choose', })
  end,
}

return {
  'hrsh7th/nvim-cmp',
  dependencies = {
    { 'hrsh7th/cmp-buffer',       event = 'BufEnter', },
    { 'hrsh7th/cmp-nvim-lsp',     dependencies = { 'neovim/nvim-lspconfig', }, },
    { 'saadparwaiz1/cmp_luasnip', dependencies = { luasnip, }, },
  },
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
        { name = 'luasnip', },
      }, {
        { name = 'buffer', },
      }),
      mapping = cmp.mapping.preset.insert({
        ['<C-u>'] = cmp.mapping.scroll_docs(-4),
        ['<C-d>'] = cmp.mapping.scroll_docs(4),
        ['<C-Space>'] = cmp.mapping.complete(),
        ['<C-c>'] = cmp.mapping.abort(),
        ['<CR>'] = cmp.mapping.confirm({ select = true, }),
      }),
    })
  end,
}
