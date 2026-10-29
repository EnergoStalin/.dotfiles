local app = require('apps')

hl.on('hyprland.start', function ()
  hl.exec_cmd(app.uwsm('qbittorrent'))
  hl.exec_cmd(app.uwsm('Telegram -startintray'))
  hl.exec_cmd(app.uwsm('keepassxc --minimized'))
  hl.exec_cmd(app.uwsm(app.electron('vesktop')))
end)