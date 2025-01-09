local function info(content)
  return ya.notify {
    title = 'hcextract',
    content = content,
    timeout = 5,
  }
end

local hovered = ya.sync(function()
  return tostring(cx.active.current.hovered and cx.active.current.hovered.url)
end)

local cwd = ya.sync(function ()
  return tostring(cx.active.current.cwd)
end)

local function sh(cmd)
  return Command('sh'):arg('-c'):arg(cmd):status()
end

return {
  entry = function()
    local tmp = '/tmp/gameripper/'
    Command('mkdir'):arg('-p'):arg(tmp):status()

    Command('cp'):arg(hovered()):arg(tmp):status()
    Command('./gameripper'):arg('-d'):arg(tmp):status()
    sh(string.format([[find '%s' -type f -name '*@*' -print0 | xargs -0 mv -t '%s']], tmp, cwd()))
    sh(string.format([[rm -rf '%s*']], tmp))

    info('Characters extracted!')
  end,
}
