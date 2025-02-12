local M = {}

local psqlexecbuf = require('s21.sql.psqlexec')

function M.get_current_day()
  return tonumber(s21:project_dir_name():match('Day(%d+)'))
end

local function get_last_ex_num_for_buf(buf)
  return tonumber(vim.api.nvim_buf_get_name(buf):match('_ex(%d+)'))
end

---Search for buffer with extractable _ex number in open windows
---@return number
function M.get_last_ex_num()
  local num = get_last_ex_num_for_buf(0)
  if num then return num end

  for _, win in ipairs(vim.api.nvim_list_wins()) do
    num = get_last_ex_num_for_buf(vim.api.nvim_win_get_buf(win))
    if num then return num end
  end

  return 0
end

---@param ex number
function M.open(ex)
  vim.cmd(string.format('edit ex%02d/day%02d_ex%02d.sql', ex, M.get_current_day(), ex))
end

---@param supp number
---@param exec boolean?
function M.advance(supp, exec)
  local exnum = M.get_last_ex_num()

  exnum = exnum + supp
  if exnum < 0 then
    vim.notify('Exnum cant go below zero', vim.log.levels.ERROR)
    return
  end
  M.open(exnum)

  if exec then psqlexecbuf() end
end

return M
