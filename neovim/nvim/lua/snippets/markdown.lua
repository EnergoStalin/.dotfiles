---@diagnostic disable: undefined-global

local function details()
  return fmt([[
    <details>
      <summary>{}</summary>

      {}
    </details>{}
  ]], {
    i(1, 'summary'), i(2), i(0)
  })
end

return {
  s('details', details())
}