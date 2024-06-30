return {
  'Exafunction/codeium.vim',
  event = 'BufEnter',
  config = function()
    vim.g.codeium_disable_bindings = 1
    vim.g.codeium_manual = 1

    vim.keymap.set('i', '<c-a>', function() return vim.fn['codeium#Accept']() end,
      { expr = true, silent = true, desc = 'Codeium Accept', })
    vim.keymap.set('i', '<m-]>', function() return vim.fn['codeium#CycleCompletions'](1) end,
      { expr = true, silent = true, desc = 'Codeium Cycle Completions', })
    vim.keymap.set('i', '<m-[>', function() return vim.fn['codeium#CycleCompletions'](-1) end,
      { expr = true, silent = true, desc = 'Codeium Cycle Completions backwards', })
    vim.keymap.set('i', '<c-]>', function() return vim.fn['codeium#Clear']() end,
      { expr = true, silent = true, desc = 'Codeium Clear', })

    vim.keymap.set('i', '<m-bslash>', function() return vim.fn['codeium#Complete']() end, { desc = 'Codeium Complete', })
  end,
}
