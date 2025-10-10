return {
  'nvim-treesitter/nvim-treesitter',
  build = ':TSUpdate',
  config = function()
    require('nvim-treesitter.configs').setup({
      ensure_installed = {
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
        'markdown',
        'markdown_inline',
        'regex',
        'rust',
        'svelte',
        'html',
        'css',
      },
      highlight = {
        enable = true,
      },
      indent = {
        enable = true,
      },
    })
  end,
}