return {
  on_init = function(client)
    if client.workspace_folders then
      --- @type string
      local path = client.workspace_folders[1].name
      if vim.uv.fs_stat(path..'/.luarc.json') or vim.uv.fs_stat(path..'/.luarc.jsonc') then
        return
      end
    end

    client.config.settings.Lua = vim.tbl_deep_extend('force', client.config.settings.Lua, {
      runtime = {
        version = 'LuaJIT',
      },
      workspace = {
        checkThirdParty = false,
        library = {
          vim.env.VIMRUNTIME
        }
      },
      format = {
        defaultConfig = {
          trailing_table_separator = 'always',
          quote_style = 'single',
        },
      },
    })

    client.notify('workspace/didChangeConfiguration', { settings = client.config.settings, })
  end,
  settings = { Lua = {}, },
}
