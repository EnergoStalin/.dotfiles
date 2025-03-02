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

Status:children_add(Status.owner, 1, Status.RIGHT)

require("mime-ext"):setup {
	fallback_file1 = true,
}

if os.getenv("NVIM") then
  require("toggle-pane"):entry("min-preview")
end
