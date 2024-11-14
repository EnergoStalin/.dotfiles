return {
  'nvim-treesitter/nvim-treesitter',
  build = ':TSUpdate',
  config = true,
  opts = {
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
      'sh',
      'markdown',
      'markdown_inline',
      'regex',
    },
    highlight = {
      enable = true,
    },
    indent = {
      enable = true,
    },
  },
}
