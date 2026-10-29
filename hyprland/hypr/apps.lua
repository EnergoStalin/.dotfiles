M = {}

function M.electron(s)
  return s .. ' --ozone-platform=wayland --enable-features=UseOzonePlatform'
end

function M.uwsm(s)
  local executable = s:match("^%S+")

  return string.format(
    "command -v %q >/dev/null 2>&1 && uwsm app -- %s",
    executable,
    s
  )
end

function M.chromium(s)
  return M.uwsm(s)
end

function M.adbsms(s)
  return 'adb -d shell cmd media_session ' .. s
end


return M