return {
  'Exafunction/codeium.vim',
  event = 'BufEnter',
  keys = {
    { '<c-a>',      function() return vim.fn['codeium#Accept']() end,             mode = 'i', expr = true, silent = true, desc = 'Codeium Accept', },
    { '<m-]>',      function() return vim.fn['codeium#CycleCompletions'](1) end,  mode = 'i', expr = true, silent = true, desc = 'Codeium Cycle Completions', },
    { '<m-[>',      function() return vim.fn['codeium#CycleCompletions'](-1) end, mode = 'i', expr = true, silent = true, desc = 'Codeium Cycle Completions backwards', },
    { '<c-]>',      function() return vim.fn['codeium#Clear']() end,              mode = 'i', expr = true, silent = true, desc = 'Codeium Clear', },
    { '<m-bslash>', function() return vim.fn['codeium#Complete']() end,           mode = 'i', expr = true, silent = true, desc = 'Codeium Complete', },
  },
  config = function()
    vim.g.codeium_disable_bindings = 1
    vim.g.codeium_manual = 1
  end,
}
