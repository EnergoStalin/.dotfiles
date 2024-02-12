return {
  "nvim-treesitter/nvim-treesitter",
  build = ":TSUpdate",
  config = function()
    require("nvim-treesitter").setup({
      ensure_installed = {
        "c",
        "cpp",
        "lua",
        "vimdoc",
        "sh",
      },
      highlight = {
        enable = true,
      },
    })
  end,
}
