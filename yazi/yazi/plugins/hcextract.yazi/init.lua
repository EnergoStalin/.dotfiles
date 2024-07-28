local function info(content)
  return ya.notify {
    title = 'hcextract',
    content = content,
    timeout = 5,
  }
end

local hovered_url = ya.sync(function()
  local h = cx.active.current.hovered
  return h and h.url
end)

return {
  entry = function()
    local hovered = tostring(hovered_url())
    if not hovered then
      return info('No file hovered')
    end

    local output, err = Command('./hcextract')
        :arg(hovered)
        :output()
    if not output then
      return info('Failed to run hcextract, error: ' .. err)
    end

    info('Characters extracted!')
  end,
}
