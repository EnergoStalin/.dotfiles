local M = {}

M.formatexpr = require('s21.sql.formatter')

require('s21.sql.docker')
require('s21.sql.init-folders')
require('s21.sql.commands')

local overseer = require('overseer')
local psqlexecbuf = require('s21.sql.psqlexec')
local ex = require('s21.sql.ex')

local group = vim.api.nvim_create_augroup('s21toolkit', { clear = true, })

vim.api.nvim_create_autocmd('BufNew', {
  pattern = '*.sql',
  callback = function(a)
    local opts = { buffer = a.buf, }
    vim.keymap.set('n', '<leader>p', psqlexecbuf, opts)
    vim.keymap.set('n', ',', function() ex.advance(-1) end, opts)
    vim.keymap.set('n', '.', function() ex.advance(1) end, opts)
  end,
  group = group,
})

overseer.run_template({ name = 'docker up', })

_G.s21.sql = M
