return {
  'Exafunction/codeium.vim',
  event = 'BufEnter',
  config = function()
    vim.g.codeium_filetypes_disabled_by_default = true
    vim.g.codeium_filetypes = {
      sql = true,
    }

    vim.keymap.set('i', '<C-\\>', function() return vim.fn['codeium#Accept']() end, { expr = true, silent = true, })
    vim.keymap.set('i', '<M-;>', function() return vim.fn['codeium#CycleCompletions'](1) end,
      { expr = true, silent = true, })
    vim.keymap.set('i', '<M-\'>', function() return vim.fn['codeium#CycleCompletions'](-1) end, { expr = true, silent = true, })
  end,
}
