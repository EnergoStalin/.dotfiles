return {
  'iamcco/markdown-preview.nvim',
  cmd = { 'MarkdownPreviewToggle', 'MarkdownPreview', 'MarkdownPreviewStop', },
  ft = { 'markdown', },
  build = function() vim.fn['mkdp#util#install']() end,
  config = function()
    vim.g.mkdp_auto_close = 0
    vim.g.mkdp_auto_start = 1
    vim.g.mkdp_images_path = vim.fn.getcwd()

    vim.keymap.set('n', '<leader>mt', '<cmd>MarkdownPreviewToggle<cr>', { desc = 'Toggle markdown preview' })
  end,
}
