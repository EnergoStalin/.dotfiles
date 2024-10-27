local function fail(s, ...) ya.notify { title = 'saucenao', content = s:format(...), timeout = 5, level = 'error' } end

local hovered_url = ya.sync(function()
  local h = cx.active.current.hovered
  return h and h.url
end)

local function gethtml(file)
  local child, err = Command('curl')
      :arg('--fail')
      :arg('-sL')
      :arg('-X'):arg('POST')
      :arg('https://saucenao.com/search.php')
      :arg('-F'):arg('file=@' .. file)
      :stdout(Command.PIPED)
      :spawn()

  if not child then
    return fail("Spawn `curl` failed with error code %s. Do you have it installed?", err)
  end

  local status, oerr = child:wait_with_output()
  if not status then
    return fail('API request failed %s', oerr)
  end

  return status.stdout
end

local function rewrite_paths(content, base_url)
  -- Replace relative paths for src and href
  content = content:gsub('src="(.-)"', function(path)
    if not path:match('^%s*%./') and not path:match('^%s*%../') and not path:match('^https?://') then
      return 'src="' .. base_url .. path .. '"'
    end

    return 'src="' .. path .. '"'
  end)


  content = content:gsub('href="(.-)"', function(path)
    if not path:match('^%s*%./') and not path:match('^%s*%../') and not path:match('^https?://') then
      return 'href="' .. base_url .. path .. '"'
    end

    return 'href="' .. path .. '"'
  end)

  return content
end

local temp = '/tmp/saucenao.yazi'
return {
  entry = function()
    local hovered = tostring(hovered_url())
    if not hovered then
      return fail('No file hovered')
    end

    local _, nameext, ext = string.match(hovered, '(.-)([^\\/]-%.?([^%.\\/]*))$')
    local name = nameext:sub(0, nameext:len() - ext:len())

    local html = rewrite_paths(gethtml(hovered), 'https://saucenao.com/')
    local tempfile = string.format('%s/%s%s', temp, name, 'html')

    Command('mkdir'):arg('-p'):arg(temp):spawn():wait()
    fs.write(Url(tempfile), html)
    Command('xdg-open'):arg(tempfile):spawn():wait()
  end,
}
