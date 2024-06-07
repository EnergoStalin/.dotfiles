return {
  'nvim-treesitter/nvim-treesitter',
  build = ':TSUpdate',
  config = function()
    require('nvim-treesitter').setup({
      ensure_installed = {
        'c',
        'cpp',
        'lua',
        'vimdoc',
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
    })
  end,
}
