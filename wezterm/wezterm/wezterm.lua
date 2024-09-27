local wezterm = require('wezterm')

local scheme = wezterm.color.get_builtin_schemes()['Edge Dark (base16)']
scheme.background = 'rgba(20,20,20,0.6)'

return {
  enable_tab_bar = false,

  color_scheme = 'Transparent',
  color_schemes = {
    ['Transparent'] = scheme
  },

  font_size = 20,
  font = wezterm.font('JetBrains Mono'),

  leader = { key = 'b', mods = 'CTRL' },
  keys = {
    {
      key = '"',
      mods = 'LEADER|SHIFT',
      action = wezterm.action.SplitVertical { domain = 'CurrentPaneDomain' },
    },
    {
      key = '%',
      mods = 'LEADER|SHIFT',
      action = wezterm.action.SplitHorizontal { domain = 'CurrentPaneDomain' },
    },
    {
      key = 'Space',
      mods = 'LEADER',
      action = wezterm.action.RotatePanes 'Clockwise'
    }
  },
}
