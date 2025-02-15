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
        disable = function(_, buf)
          local max_filesize = 100 * 1024 -- 100 KB
          local ok, stats = pcall(vim.uv.fs_stat, vim.api.nvim_buf_get_name(buf))
          if ok and stats and stats.size > max_filesize then
            return true
          end
        end,
      },
      indent = {
        enable = true,
      },
    })
  end,
}
