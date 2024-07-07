return {
  'folke/tokyonight.nvim',
  lazy = false,
  priority = 1000,
  config = function()
    require('tokyonight').setup({
      transparent = true,
      on_highlights = function(hl)
        local none = { bg = nil }
        hl.FloatBorder = none
        hl.TelescopeNormal = none
        hl.TelescopeBorder = none
        hl.TelescopeTitle = none
        hl.TelescopePromptBorder = none
        hl.TelescopePromptTitle = none
      end,
    })

    vim.cmd('colorscheme tokyonight')
  end,
}
