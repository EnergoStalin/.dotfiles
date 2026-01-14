return {
  'nvim-treesitter/nvim-treesitter',
  build = ':TSUpdate',
  lazy = false,
  config = function()
    local ts = require('nvim-treesitter')
    local fts = {
      'c',
      'cpp',
      'lua',
      'vimdoc',
      'jsdoc',
      'gitignore',
      'json',
      'yaml',
      'typescript',
      'javascript',
      'python',
      'markdown',
      'markdown_inline',
      'regex',
      'rust',
      'svelte',
      'html',
      'css',
    }

    vim.api.nvim_create_autocmd('FileType', {
      pattern = fts,
      callback = function() vim.treesitter.start() end,
    })

    ts.setup({
      install_dir = vim.fn.stdpath('data') .. '/site'
    })

    ts.install(fts)
  end,
}