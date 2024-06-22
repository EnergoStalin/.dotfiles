return {
  name = 'AdbYandexBrowserOpen',
  params = {
    url = {
      name = 'url',
      type = 'string',
      description = '%local% substituted as local interface ip'
    },
  },
  builder = function(o)
    local interface = io.popen([[ip -o addr show dev eno1]]):read()
    local ip = string.sub(interface, 17, string.find(interface, '/', 17) - 1)

    if string.find(o.url, '%%local%%') then o.url = string.gsub(o.url, '%%local%%', ip) end

    return {
      name = 'adb open',
      cmd = {
        'adb',
        'shell',
        'am start -n com.yandex.browser/com.yandex.browser.YandexBrowserMainActivity -a android.intent.action.VIEW -d ' .. o.url
      },
      cwd = vim.fn.getcwd(),
      components = {
        'default',
        'unique',
        {
          'dependencies',
          task_names = {
            'build ppixiv',
          },
        },
      }
    }
  end
}
