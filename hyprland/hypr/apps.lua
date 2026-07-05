M = {}

function M.electron(s)
  return s .. ' --ozone-platform=wayland --enable-features=UseOzonePlatform'
end

function M.uwsm(s)
  return 'uwsm app -- ' .. s
end

function M.adbsms(s)
  return 'adb -d shell cmd media_session ' .. s
end


return M
