require('core.mode.zapret')

if not require('core.mode.pager') then
  require('lazy').setup({
    spec = {
      { import = 'plugins' },
    }
  })
end