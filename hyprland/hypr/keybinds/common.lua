return function (v)
  hl.bind(v.mod .. 'RETURN', hl.dsp.exec_cmd(v.terminal))
  hl.bind(v.modS .. 'G', hl.dsp.dpms('toggle'))
  hl.bind(v.modS .. 'E', hl.dsp.exit())
  hl.bind(v.modS .. 'F', hl.dsp.window.fullscreen('toggle'))
  hl.bind(v.mod .. 'Q', hl.dsp.window.close())

  hl.bind(v.mod .. 'D', hl.dsp.exec_cmd(v.menu))

  hl.bind(v.mod .. 'h', hl.dsp.focus({ direction = 'left' }))
  hl.bind(v.mod .. 'j', hl.dsp.focus({ direction = 'down' }))
  hl.bind(v.mod .. 'k', hl.dsp.focus({ direction = 'up' }))
  hl.bind(v.mod .. 'l', hl.dsp.focus({ direction = 'right' }))

  hl.bind(v.mod .. 'SPACE', hl.dsp.focus({ urgent_or_last = true }))
  hl.bind(v.modS .. 'SPACE', hl.dsp.window.float({ toggle = true }))

  for i = 1, 10 do
    local key = i % 10
    hl.bind(v.mod .. key,  hl.dsp.focus({ workspace = i}))
    hl.bind(v.modS .. key, hl.dsp.window.move({ workspace = i, follow = false }))
  end

  hl.bind(v.mod .. 'mouse:272', hl.dsp.window.drag(),   { mouse = true })
  hl.bind(v.mod .. 'mouse:273', hl.dsp.window.resize(), { mouse = true })

  hl.bind(v.modS .. 'M', hl.dsp.layout('togglesplit'))

  hl.bind(v.mod .. 'minus', hl.dsp.workspace.toggle_special('magic'))
  hl.bind(v.modS .. 'minus', hl.dsp.window.move({ workspace = 'special:magic', follow = false }))
end