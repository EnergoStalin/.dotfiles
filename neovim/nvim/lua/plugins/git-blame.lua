return {
  'f-person/git-blame.nvim',
  -- load the plugin at startup
  event = 'VeryLazy',
  -- Because of the keys part, you will be lazy loading this plugin.
  -- The plugin wil only load once one of the keys is used.
  -- If you want to load the plugin at startup, add something like event = "VeryLazy",
  -- or lazy = false. One of both options will work.
  opts = function()
    local hl_cursor_line = vim.api.nvim_get_hl(0, { name = 'CursorLine', })
    local hl_comment = vim.api.nvim_get_hl(0, { name = 'Comment', })
    local hl_combined = vim.tbl_extend('force', hl_comment, { bg = hl_cursor_line.bg, })
    vim.api.nvim_set_hl(0, 'CursorLineBlame', hl_combined)

    return {
      enabled = true,
      message_template = '  <author> 󰇂 <date> 󰎛 <summary> <sha>',
      date_format = '%r',
      virtual_text_column = 1,
      max_commit_summary_length = 30,
      highlight_group = 'CursorLineBlame',
    }
  end,
}
