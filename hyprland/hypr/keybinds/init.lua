return function (hostname)
  local vars = require('keybinds.vars')

  require('keybinds.common')(vars)
  require('keybinds.' .. hostname)(vars)
end