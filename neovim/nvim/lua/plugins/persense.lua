return {
  'vyfor/cord.nvim',
  build = ':Cord update',
  event = 'VeryLazy',
  -- tag = 'v2.2.7',
  opts = {
    -- log_level = 'trace',
    advanced = {
      server = {
        timeout = 2
      }
    }
  },
  config = true
}