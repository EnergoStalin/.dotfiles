return {
  'rcarriga/nvim-notify',
  keys = {
    { '<c-a>', '<cmd>Notifications<cr>', mode = 'n', desc = 'Show notification history' }
  },
  lazy = false,
  config = function()
    local plugin = require('notify')
    plugin.setup({
      fps = 30,
      render = 'wrapped-compact',
      stages = 'static',
      top_down = false
    })
    vim.notify = plugin
  end
}