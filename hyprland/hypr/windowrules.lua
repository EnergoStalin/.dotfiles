hl.window_rule({
  name  = 'fix-xwayland-drags',
  match = {
    class      = '^$',
    title      = '^$',
    xwayland   = true,
    float      = true,
    fullscreen = false,
    pin        = false,
  },

  no_focus = true,
})

hl.window_rule({
  name  = 'protanki-auto-fullscreen',
  match = {
    class      = 'steam_app_default',
    xwayland   = true,
    float      = false,
  },
  fullscreen = true,
})

hl.window_rule({
  name  = 'hide-keepassxc',
  match = { class = 'org.keepassxc.KeePassXC', },
  no_screen_share = true,
})

hl.window_rule({
  name  = 'hide-keepassxc',
  match = { class = 'org.qbittorrent.qBittorrent', },
  no_screen_share = true,
})
