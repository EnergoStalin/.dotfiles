return {
  'crnvl96/lazydocker.nvim',
  dependencies = { 'MunifTanjim/nui.nvim', },
  config = true,
  opts = {
    window = {
      settings = {
        width = 1,
        height = 1,
        border = nil,
      },
    },
  },
  keys = {
    {
      '<leader>ld',
      function()
        require('lazydocker').open({ engine = 'docker' })
      end,
      desc = 'Open Lazydocker floating window',
    },
  },
}