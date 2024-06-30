return {
  'rcarriga/nvim-notify',
  lazy = false,
  config = function()
    local notify = require('notify')
    notify.setup({
      timeout = 2000,
      stages = 'fade',
      top_down = false,
      fps = 15
    })
    vim.notify = notify
  end,
}
