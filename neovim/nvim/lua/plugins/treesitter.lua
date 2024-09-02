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
      'typescript',
      'sh',
      'markdown',
      'markdown_inline',
      'java',
    },
    highlight = {
      enable = true,
    },
    indent = {
      enable = true,
    },
  },
}
