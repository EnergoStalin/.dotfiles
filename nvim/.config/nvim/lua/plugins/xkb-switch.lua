return {
  'ivanesmantovich/xkbswitch.nvim',
  enable = vim.env.DISPLAY ~= nil,
  config = function()
    require('xkbswitch').setup({})
  end,
}
