return {
  'crnvl96/lazydocker.nvim',
  dependencies = { 'MunifTanjim/nui.nvim', },
  config = true,
  opts = {
    popup_window = {
      size = {
        width = '100%',
        height = '100%',
      },
      border = nil,
    },
  },
  keys = {
    {
      '<leader>ld',
      '<cmd>LazyDocker<cr>',
      desc = 'Open Lazydocker floating window',
    },
  },
}
