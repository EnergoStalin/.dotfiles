return {
  'patwie/include-guard.nvim',
  event = 'BufEnter *.h',
  config = function()
    local guard = require('include-guard')
    guard.setup({
      copyright_holder = 'eckhardy',
      add_copyringt = true,
    })

    -- Example short cut ("w" as wrap)
    vim.keymap.set('n', '<leader>ww', require('include-guard').AddIncludeGuardAndCopyright)
    vim.keymap.set('n', '<leader>wg', require('include-guard').AddIncludeGuard)
    vim.keymap.set('n', '<leader>wc', require('include-guard').UpdateCopyright)
  end,
}
