return {
  'wakatime/vim-wakatime',
  lazy = false,
  cond = function ()
    return vim.fn.filereadable(vim.fs.joinpath(vim.fn.getcwd(), '.wakatime-project')) == 1
  end
}
