local function skip_msg(filter)
  return {
    filter = vim.tbl_extend('force', {
      event = 'msg_show',
    }, filter),
    opts = { skip = true, },
  }
end

return {
  'folke/noice.nvim',
  event = 'VeryLazy',
  config = true,
  opts = {
    lsp = {
      override = {
        ['vim.lsp.util.convert_input_to_markdown_lines'] = true,
        ['vim.lsp.util.stylize_markdown'] = true,
        ['cmp.entry.get_documentation'] = true, -- requires hrsh7th/nvim-cmp
      },
    },
    routes = {
      skip_msg({kind = 'search_count'}),
      skip_msg({find = 'written', kind = ''}),
    },
    presets = {
      bottom_search = true,         -- use a classic bottom cmdline for search
      command_palette = true,       -- position the cmdline and popupmenu together
      long_message_to_split = true, -- long messages will be sent to a split
      inc_rename = false,           -- enables an input dialog for inc-rename.nvim
      lsp_doc_border = false,       -- add a border to hover docs and signature help
    },
  },
  dependencies = {
    'MunifTanjim/nui.nvim',
    'rcarriga/nvim-notify',
  },
}