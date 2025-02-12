local M = {}

local psqlexecbuf = require('s21.sql.psqlexec')

function M.get_current_day()
  return tonumber(s21:project_dir_name():match('Day(%d+)'))
end

local function get_last_ex_num_for_buf(buf)
  return tonumber(vim.api.nvim_buf_get_name(buf):match('_ex(%d+)'))
end

function M.get_last_ex_num()
  local num = get_last_ex_num_for_buf(0)
  if num then return num end

  for _, bn in ipairs(vim.api.nvim_list_bufs()) do
    num = get_last_ex_num_for_buf(bn)
    if num then return num end
  end

  return nil
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
