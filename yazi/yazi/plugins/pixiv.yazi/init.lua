local pixiv = 'https://www.pixiv.net/en/artworks/%s#ppixiv'
local pixiv_like = '%d%d%d%d%d%d%d%d+_p?%d+'

local function parseid(file)
  local _, nameext, ext = string.match(file, '(.-)([^\\/]-%.?([^%.\\/]*))$')
  local name = nameext:sub(0, nameext:len() - ext:len())

  if not string.match(name, pixiv_like) then
    return
  end

  return name:sub(0, name:find('_') - 1)
end

local hovered = ya.sync(function()
  local h = cx.active.current.hovered
  return tostring(h and h.url)
end)

local selected = ya.sync(function()
  local files = {}
  for _, u in pairs(cx.active.selected) do
    table.insert(files, tostring(u))
  end

  return files
end)

local to_id_set = function(files)
  local ids = {}
  for _, u in pairs(files) do
    local id = parseid(tostring(u))
    if id then
      ids[id] = true
    end
  end

  return ids
end

local open = function(id)
  if id == nil then
    return
  end

  Command('xdg-open'):arg(string.format(pixiv, id)):spawn():wait()
end

return {
  entry = function()
    local files = selected()
    if next(files) == nil then
      return open(parseid(hovered()))
    end

    for u, _ in pairs(to_id_set(files)) do
      open(u)
    end
  end
}
