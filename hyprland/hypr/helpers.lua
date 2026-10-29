local M = {}

function M.capture(cmd)
  local pipe = assert(io.popen(cmd, "r"))
  local output = pipe:read("*a")
  pipe:close()
  return output:gsub("%s+$", "")
end

return M