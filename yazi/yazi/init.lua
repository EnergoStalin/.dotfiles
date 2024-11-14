function Status:owner()
  local h = cx.active.current.hovered
  if h == nil or ya.target_family() ~= 'unix' then
    return ui.Line {}
  end

  return ui.Line {
    ui.Span(ya.user_name(h.cha.uid) or tostring(h.cha.uid)):fg('magenta'),
    ui.Span(':'),
    ui.Span(ya.group_name(h.cha.gid) or tostring(h.cha.gid)):fg('magenta'),
    ui.Span(' '),
  }
end

Status._right = {
  { Status.owner,       id = 4, order = 1000, },
  { Status.permissions, id = 5, order = 1000, },
  { Status.percentage,  id = 6, order = 2000, },
  { Status.position,    id = 7, order = 3000, },
}

require("mime-ext"):setup {
	fallback_file1 = true,
}
