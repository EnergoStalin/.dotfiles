local putils = require('linking-utils')

SimpleEventHook({
  name = 'linking/find-user-target',
  before = 'linking/find-defined-target',
  interests = {
    EventInterest({
      Constraint({ 'event.type', '=', 'select-target' }),
    }),
  },
  execute = function(event)
    local source, om, si, si_props, si_flags, target =
      putils:unwrap_select_target_event(event)

    if target then
      return
    end

    if
      si_props['application.process.binary'] ~= 'electron' or
      si_props['application.name'] ~= 'Chromium'
    then return end

    local media_sink_si = om:lookup({
      Constraint({ 'node.name', '=', 'easyeffects_sink' })
    })

    event:set_data('target', media_sink_si)
  end,
}):register()
