return {
  'kylechui/nvim-surround',
  event = 'VeryLazy',
  lazy = false,
  config = function()
    require('nvim-surround').setup({
      --        keymaps =       -- Defines plugin keymaps
      --        surrounds =     -- Defines surround keys and behavior
      --        aliases =       -- Defines aliases
      --        highlight =     -- Defines highlight behavior
      --        move_cursor =   -- Defines cursor behavior
      --        indent_lines =  -- Defines line indentation behavior
    })
  end,
}
