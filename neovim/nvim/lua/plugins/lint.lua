local function filter_exists(tbl)
  local exists = {}
  for i = 1, #tbl do
    if vim.fn.executable(tbl[i]) == 1 then
      exists[#exists+1] = tbl[i]
    end
  end
  return exists
end

return {
  'mfussenegger/nvim-lint',
  config = function()
    local lint = require('lint')

    lint.linters_by_ft = {
      python = filter_exists({ 'ruff', 'dmypy' })
    }

    local group = vim.api.nvim_create_augroup('lint', { clear = true })
    vim.api.nvim_create_autocmd({ 'VimEnter', 'BufReadPost' }, {
      callback = function(args)
        vim.schedule(function () lint.try_lint() end)

        vim.api.nvim_create_autocmd('BufWritePost', {
          buffer = args.buf,
          callback = function() lint.try_lint() end,
          group = group
        })
      end,
      group = group
    })
  end
}