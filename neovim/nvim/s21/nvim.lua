local M = { i3 = {}, }

---@return string
function M.project_root()
  return vim.fs.find('.git', { upward = true, })[1]
end

---@return string
function M:project_dir_name()
  return vim.fs.basename(vim.fs.dirname(self:project_root()))
end

---@return string
function M.project_ssh_url()
  return vim.system({ 'git', 'remote', 'get-url', 'origin', }):wait().stdout
end

---@return string
function M.project_web_url()
  return string.format(
    'https://repos.21-school.ru%s/-/tree/develop/src',
    string.sub(M.project_ssh_url(), 38, -6)
  )
end

---@param term string
---@return boolean
function M.i3.window_title_contains(term)
  local jq = vim.system({ 'jq', '-r', '.nodes | .. | objects | .name? // empty', }, {
    stdin = vim.system({ 'i3-msg', '-t', 'get_tree', }):wait().stdout,
  }):wait().stdout
  if not jq then
    vim.notify('Getting i3 status tree failed', vim.log.levels.ERROR)
    return false
  end

  return jq:find(term, 1, true) ~= nil
end

local overseer = require('overseer')

overseer.register_template({
  name = 'preview-start',
  builder = function()
    return {
      name = 'vivify-server-start',
      cmd = (not M.i3.window_title_contains(M:project_dir_name())) and [[
        firefox && sleep .1 && i3-msg resize set 1400 px > /dev/null && vivify-server ../README*.md
      ]] or 'echo Already opened',
      components = {
        'unique',
        'on_exit_set_status',
        'on_complete_notify',
        { 'on_complete_dispose', require_view = { 'FAILURE', }, timeout = 10, },
      },
    }
  end,
})

overseer.run_template({ name = 'preview-start', })

vim.keymap.set('n', '<leader>;', function()
  vim.system({
    'firefox',
    '--new-tab',
    M.project_web_url(),
  }):wait()
end, { noremap = true, })

-- Automagically switch to develop branch
if vim.system({ 'git', 'switch', 'develop', }):wait().code ~= 0 then
  vim.system({ 'git', 'switch', '-b', 'develop', }):wait()
end

_G.s21 = M

if vim.fn.getcwd():match('/SQL/') then require('s21.sql.nvim') end
