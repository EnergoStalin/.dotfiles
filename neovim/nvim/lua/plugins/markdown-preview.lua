return {
  'iamcco/markdown-preview.nvim',
  cmd = { 'MarkdownPreviewToggle', 'MarkdownPreview', 'MarkdownPreviewStop', },
  ft = { 'markdown', },
  keys = {
    { '<leader>mt', '<cmd>MarkdownPreviewToggle<cr>', desc = 'Toggle markdown preview', },
  },
  build = function() vim.fn['mkdp#util#install']() end,
  config = function()
    vim.g.mkdp_auto_close = 0
    vim.g.mkdp_auto_start = 1
    vim.g.mkdp_images_path = vim.fn.getcwd()
  end,
}
