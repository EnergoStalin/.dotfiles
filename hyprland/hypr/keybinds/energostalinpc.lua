return function (v)
  local app = require('apps')

  hl.bind(v.mod .. 'B', hl.dsp.exec_cmd(app.chromium('chromium')))
  hl.bind(v.mod .. 'T', hl.dsp.exec_cmd('Telegram'))
  hl.bind(v.mod .. 'O', hl.dsp.exec_cmd('zsh -ic osuw'))
  hl.bind(v.mod .. 'G', hl.dsp.exec_cmd('lutris'))
  hl.bind(v.mod .. 'V', hl.dsp.exec_cmd(app.electron('vesktop')))
  hl.bind(v.mod .. 'M', hl.dsp.exec_cmd('geary'))

  hl.bind(v.modS .. 'S', hl.dsp.exec_cmd('XDG_CURRENT_DESKTOP=sway flameshot gui -c'))
  hl.bind(v.modS .. 'P', hl.dsp.exec_cmd('hyprpicker | wl-copy'))

  local XF86OPTS = { locked = true, repeating = true }
  hl.bind("XF86AudioRaiseVolume", hl.dsp.exec_cmd(app.adbsms('volume --adj raise')),  XF86OPTS)
  hl.bind("XF86AudioLowerVolume", hl.dsp.exec_cmd(app.adbsms('volume --adj lower')),  XF86OPTS)
  hl.bind("XF86AudioPlay",        hl.dsp.exec_cmd(app.adbsms('dispatch play-pause')), XF86OPTS)
end