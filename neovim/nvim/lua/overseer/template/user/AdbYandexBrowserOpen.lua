return {
  name = 'AdbYandexBrowserOpen',
  hide = true,
  params = {
    url = {
      name = 'url',
      type = 'string',
      description = '%local% substituted as local interface ip'
    },
  },
  builder = function(o)
    local gateway = string.gmatch(io.popen([[ip route | grep default]]):read(), [[dev (%w+)]])()
    local interface = io.popen([[ip -o addr show dev ]] .. gateway):read()
    local ip = string.sub(interface, 17, string.find(interface, '/', 17) - 1)

    if string.find(o.url, '%%local%%') then o.url = string.gsub(o.url, '%%local%%', ip) end

    return {
      name = 'YandexBrowserOpen',
      cmd = {
        'adb',
        'shell',
        vim.fn.join({
          'am', 'start',
          '-n', 'com.yandex.browser/com.yandex.browser.YandexBrowserMainActivity',
          '-a', 'android.intent.action.VIEW',
          '-d', o.url
        }, ' '),
      },
      cwd = vim.fn.getcwd(),
    }
  end
}
