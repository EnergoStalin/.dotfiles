local app = require('apps')

local menu = 'wofi --show drun'
local mod = 'SUPER + '
local modS = mod .. 'SHIFT + '
local terminal = 'kitty'

hl.bind(mod .. 'RETURN', hl.dsp.exec_cmd(terminal))
hl.bind(modS .. 'G', hl.dsp.dpms('toggle'))
hl.bind(modS .. 'E', hl.dsp.exit())
hl.bind(modS .. 'F', hl.dsp.window.fullscreen('toggle'))
hl.bind(mod .. 'Q', hl.dsp.window.close())

hl.bind(mod .. 'D', hl.dsp.exec_cmd(menu))
hl.bind(mod .. 'B', hl.dsp.exec_cmd(app.electron('chromium')))
hl.bind(mod .. 'T', hl.dsp.exec_cmd('Telegram'))
hl.bind(mod .. 'O', hl.dsp.exec_cmd('zsh -ic osuw'))
hl.bind(mod .. 'G', hl.dsp.exec_cmd('lutris'))
hl.bind(mod .. 'V', hl.dsp.exec_cmd(app.electron('discord')))
hl.bind(mod .. 'M', hl.dsp.exec_cmd('geary'))

hl.bind(modS .. 'S', hl.dsp.exec_cmd('XDG_CURRENT_DESKTOP=sway flameshot gui -c'))
hl.bind(modS .. 'P', hl.dsp.exec_cmd('hyprpicker | wl-copy'))
hl.bind('ALT + Z',   hl.dsp.exec_cmd('kill -USR1 $(systemctl --user show gpu-screen-recorder.service -p MainPID --value)'))

hl.bind(mod .. 'h', hl.dsp.focus({ direction = 'left' }))
hl.bind(mod .. 'j', hl.dsp.focus({ direction = 'down' }))
hl.bind(mod .. 'k', hl.dsp.focus({ direction = 'up' }))
hl.bind(mod .. 'l', hl.dsp.focus({ direction = 'right' }))

hl.bind(mod .. 'SPACE', hl.dsp.focus({ urgent_or_last = true }))
hl.bind(modS .. 'SPACE', hl.dsp.window.float({ toggle = true }))

for i = 1, 10 do
  local key = i % 10
  hl.bind(mod .. key,  hl.dsp.focus({ workspace = i}))
  hl.bind(modS .. key, hl.dsp.window.move({ workspace = i, follow = false }))
end

hl.bind(mod .. 'mouse:272', hl.dsp.window.drag(),   { mouse = true })
hl.bind(mod .. 'mouse:273', hl.dsp.window.resize(), { mouse = true })

hl.bind(modS .. 'M', hl.dsp.layout('togglesplit'))

hl.bind(mod .. 'minus', hl.dsp.workspace.toggle_special())
hl.bind(modS .. 'minus', hl.dsp.window.move({ workspace = 'special:magic', follow = false }))

local XF86OPTS = { locked = true, repeating = true }
hl.bind("XF86AudioRaiseVolume", hl.dsp.exec_cmd(app.adbsms('volume --adj raise')),  XF86OPTS)
hl.bind("XF86AudioLowerVolume", hl.dsp.exec_cmd(app.adbsms('volume --adj lower')),  XF86OPTS)
hl.bind("XF86AudioPlay",        hl.dsp.exec_cmd(app.adbsms('dispatch play-pause')), XF86OPTS)
