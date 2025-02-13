local M = {}

M.formatexpr = require('s21.sql.formatter')

require('s21.sql.docker')
require('s21.sql.init-folders')
require('s21.sql.commands')

local overseer = require('overseer')
local psqlexecbuf = require('s21.sql.psqlexec')
local config = require('s21.sql.config')
local ex = require('s21.sql.ex')

vim.api.nvim_create_autocmd('BufEnter', {
  pattern = '*.sql',
  group = config.group,
  callback = function(a)
    local opts = { buffer = a.buf, }
    vim.keymap.set('n', '<leader>p', psqlexecbuf, opts)
    vim.keymap.set('n', ',', function() ex.advance(-1) end, opts)
    vim.keymap.set('n', '.', function() ex.advance(1, true) end, opts)
  end,
})

overseer.run_template({ name = 'docker up', })

_G.s21.sql = M
