return {
  'patwie/include-guard.nvim',
  event = 'BufEnter *.h*',
  config = function()
    local guard = require('include-guard')
    guard.setup({
      copyright_holder = 'eckhardy',
      add_copyringt = true,
    })

    -- Example short cut ("w" as wrap)
    vim.keymap.set('n', '<leader>ww', require('include-guard').AddIncludeGuardAndCopyright, { desc = 'Add include guard and copyright' })
    vim.keymap.set('n', '<leader>wg', require('include-guard').AddIncludeGuard, { desc = 'Add include guard' })
    vim.keymap.set('n', '<leader>wc', require('include-guard').UpdateCopyright, { desc = 'Update copyright' })
  end,
}
