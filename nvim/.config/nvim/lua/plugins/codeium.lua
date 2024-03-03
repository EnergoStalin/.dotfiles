return {
  'Exafunction/codeium.vim',
  event = 'BufEnter',
  config = function()
    vim.g.codeium_disable_bindings = 1
    vim.g.codeium_manual = 1

    vim.keymap.set('i', '<tab>', function() return vim.fn['codeium#Accept']() end, { expr = true, silent = true, })
    vim.keymap.set('i', '<m-]>', function() return vim.fn['codeium#CycleCompletions'](1) end,
      { expr = true, silent = true, })
    vim.keymap.set('i', '<m-[>', function() return vim.fn['codeium#CycleCompletions'](-1) end,
      { expr = true, silent = true, })
    vim.keymap.set('i', '<c-]>', function() return vim.fn['codeium#Clear']() end, { expr = true, silent = true, })

    vim.keymap.set('i', '<m-bslash>', function() return vim.fn['codeium#Complete']() end)
  end,
}
