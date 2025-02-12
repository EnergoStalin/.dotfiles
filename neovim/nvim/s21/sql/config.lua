return {
  ---@diagnostic disable-next-line: param-type-mismatch
  data_path = vim.fs.joinpath(vim.fn.stdpath('config'), 's21', 'sql'),
  postgres = {
    password = 'ydrahkce',
    user = 'eckhardy',
    db = 'school21',
    port = 5432,
  },
}
