require('keybinds')
require('gestures')
require('windowrules')

local app = require('apps')

hl.monitor({
  output = 'DP-1',
  mode = '3440x1440@165',
  vrr = true
})

hl.config({
  general = {
    gaps_in = 0,
    gaps_out = 0,
    border_size = 0,
    layout = 'dwindle',
  },
  decoration = {
    rounding = 0,
    rounding_power = 0,
    shadow = {
      enabled = false,
    },
    blur = {
      enabled = false,
    },
  },
  animations = {
    enabled = true,
  },
  dwindle = {
    preserve_split = true,
    force_split = 2,
  },
  misc = {
    force_default_wallpaper = 1,
    disable_watchdog_warning = true,
    disable_xdg_env_checks = true,
    disable_splash_rendering = true,
    disable_hyprland_logo = true,
  },
  input = {
    kb_layout = 'us,ru',
    kb_options = 'grp:alt_shift_toggle',
    follow_mouse = 1,
    sensitivity = 0,
  },
  ecosystem = {
    no_update_news = true,
    no_donation_nag = true,
  },
  binds = {
    drag_threshold = 10,
  },
})

hl.on('hyprland.start', function ()
  hl.exec_cmd(app.uwsm('qbittorrent'))
  hl.exec_cmd(app.uwsm('Telegram -startintray'))
  hl.exec_cmd(app.uwsm('keepassxc --minimized'))
  hl.exec_cmd(app.uwsm(app.electron('discord')))
end)