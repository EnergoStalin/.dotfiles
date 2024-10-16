local wezterm = require('wezterm')

local action = wezterm.action
local scheme = wezterm.color.get_builtin_schemes()['Edge Dark (base16)']
scheme.background = 'rgba(20,20,20,0.8)'

return {
  enable_tab_bar = false,

  color_scheme = 'Transparent',
  color_schemes = {
    ['Transparent'] = scheme
  },
  window_padding = {
    left = 0,
    right = 0,
    top = 0,
    bottom = 0,
  },
  window_frame = {
    border_left_width = 0,
    border_right_width = 0,
    border_bottom_height = 0,
    border_top_height = 0,
  },

  font_size = 24,
  font = wezterm.font('JetBrains Mono'),

  -- leader = { key = 'b', mods = 'CTRL' },
  keys = {
    {
      key = '"',
      mods = 'CTRL|SHIFT',
      action = action.SplitVertical { domain = 'CurrentPaneDomain' },
    },
    {
      key = '%',
      mods = 'CTRL|SHIFT',
      action = action.SplitHorizontal { domain = 'CurrentPaneDomain' },
    },
    {
      key = 'H',
      mods = 'CTRL|SHIFT',
      action = action.ActivatePaneDirection 'Left'
    },
    {
      key = 'L',
      mods = 'CTRL|SHIFT',
      action = action.ActivatePaneDirection 'Right'
    },
    {
      key = 'J',
      mods = 'CTRL|SHIFT',
      action = action.ActivatePaneDirection 'Down'
    },
    {
      key = 'K',
      mods = 'CTRL|SHIFT',
      action = action.ActivatePaneDirection 'Up'
    },
    {
      key = 'h',
      mods = 'CTRL|ALT',
      action = action.AdjustPaneSize { 'Left', 5 }
    },
    {
      key = 'l',
      mods = 'CTRL|ALT',
      action = action.AdjustPaneSize { 'Right', 5 }
    },
    {
      key = 'j',
      mods = 'CTRL|ALT',
      action = action.AdjustPaneSize { 'Down', 5 }
    },
    {
      key = 'k',
      mods = 'CTRL|ALT',
      action = action.AdjustPaneSize { 'Up', 5 }
    },
    {
      key = 'Z',
      mods = 'CTRL|SHIFT',
      action = action.TogglePaneZoomState
    },
    {
      key = 'R',
      mods = 'CTRL|SHIFT',
      action = action.RotatePanes 'Clockwise'
    },
  },
}
