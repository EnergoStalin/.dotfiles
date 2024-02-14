return {
  on_init = function(client)
    vim.keymap.set('n', '<leader>bf', '<cmd>lua vim.lsp.buf.format()<cr>')

    local path = client.workspace_folders[1].name
    if vim.loop.fs_stat(path .. '/.luarc.json') or vim.loop.fs_stat(path .. '/.luarc.jsonc') then
      return true
    end

    client.config.settings = vim.tbl_deep_extend('force', client.config.settings, {
      Lua = {
        runtime = {
          version = 'LuaJIT',
        },
        -- Make the server aware of Neovim runtime files
        workspace = {
          checkThirdParty = false,
          library = {
            vim.env.VIMRUNTIME,
          },
          -- or pull in all of 'runtimepath'. NOTE: this is a lot slower
          -- library = vim.api.nvim_get_runtime_file("", true)
        },
        format = {
          defaultConfig = {
            trailing_table_separator = 'always',
            quote_style = 'single',
          },
        },
      },
    })

    client.notify('workspace/didChangeConfiguration', { settings = client.config.settings, })
  end,
}
