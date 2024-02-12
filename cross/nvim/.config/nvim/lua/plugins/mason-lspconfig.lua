package.path = package.path .. ";../?.lua"


return {
  "williamboman/mason-lspconfig.nvim",
  dependencies = {
    "williamboman/mason.nvim",
    "neovim/nvim-lspconfig",
  },
  config = function()
    require("mason").setup()
    require("mason-lspconfig").setup({
      ensure_installed = { "lua_ls", "ast_grep" },
      handlers = {
        function(server)
          local status, config = pcall(require, "lsp." .. server)
          if (not status) then config = {} end

          require("lspconfig")[server].setup(config)
        end,
      },
    })
  end,
}
