return {
  'midoBB/nvim-quicktype',
  cmd = 'QuickType',
  keys = {
    { '<leader>q', '<cmd>QuickType<cr>', mode = { 'n', }, desc = 'Trigger quicktype command', },
  },
  ft = {
    'typescript',
    'python',
    'java',
    'go',
    'rust',
    'cs',
    'swift',
    'elixir',
    'kotlin',
    'typescriptreact',
  },
  config = true,
  opts = {
    global = {
      cmd = 'quicktype',
      src_lang = 'json',
      no_combine_classes = false,
      all_properties_optional = true,
      alphabetize_properties = true,
      telemetry = 'disable',
      output_file = nil,
      debug_dir = nil,
      clipboard_source_register = nil,
    },
  },
}
