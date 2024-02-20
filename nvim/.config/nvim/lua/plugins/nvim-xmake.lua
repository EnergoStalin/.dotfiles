return {
  'Mythos-404/xmake.nvim',
  lazy = true,
  event = 'BufReadPost xmake.lua',
  config = function()
    require('xmake').setup({
      compile_command = {
        dir = '.',
      },
    })
  end,
  dependencies = { 'MunifTanjim/nui.nvim', 'nvim-lua/plenary.nvim', },
}
