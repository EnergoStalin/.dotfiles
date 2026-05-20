return {
  name = 'AdbLemurBrowserOpen',
  hide = true,
  params = {
    url = {
      name = 'url',
      type = 'string',
      description = '%local% substituted as local interface ip'
    },
    components = {
      name = 'components',
      type = 'list',
      default = {},
      optional = true,
      description = 'additional components to attach'
    },
  },
  builder = function(o)
    local gateway = string.gmatch(io.popen([[ip route | grep default]]):read(), [[dev (%w+)]])()
    local interface = io.popen([[ip -o addr show dev ]] .. gateway):read()
    local ip = string.sub(interface, 17, string.find(interface, '/', 17) - 1)

    if string.find(o.url, '%%local%%') then o.url = string.gsub(o.url, '%%local%%', ip) end

    return {
      name = 'LemurBrowserOpen',
      cmd = {
        'adb',
        'shell',
        vim.fn.join({
          'am', 'start',
          '-n', 'com.lemurbrowser.exts/com.google.android.apps.chrome.Main',
          '-a', 'android.intent.action.VIEW',
          '-d', string.format("'%s'", o.url)
        }, ' '),
      },
      cwd = vim.fn.getcwd(),
      components = vim.tbl_extend('force', { 'default', 'unique', }, o.components)
    }
  end
}