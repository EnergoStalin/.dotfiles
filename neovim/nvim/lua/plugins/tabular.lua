return {
  'godlygeek/tabular',
  keys = {
    { '<leader>a ', ":'<,'>Tabularize / /l0r0<cr>",          mode = { 'v', }, noremap = true, },
    { '<leader>a,', ":'<,'>Tabularize /,\\zs /l0r0<cr>",     mode = { 'v', }, noremap = true, },
    { '<leader>a:', ":'<,'>Tabularize /^[^:]*\\zs/l1r0<cr>", mode = { 'v', }, noremap = true, },
    { '<leader>a=', ":'<,'>Tabularize /^[^=]*\\zs/l1r0<cr>", mode = { 'v', }, noremap = true, },
    { '<leader>a|', ":'<,'>Tabularize /|<cr>",               mode = { 'v', }, noremap = true, },
  },
}
