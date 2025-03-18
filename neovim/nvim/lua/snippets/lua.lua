---@diagnostic disable: undefined-global

local function dfmt(direct, str, nodes)
  local w = string.match(str, '%s*') or ''
  local prefix = (not direct and (w .. ',\n') or '')
  return fmt(prefix .. str, nodes)
end

local function dwrap(str, nodes)
  return function(direct)
    return dfmt(direct, str, vim.deepcopy(nodes))
  end
end

local function param()
  return fmt([[
    {} = {{
      type = '{}',
      default = {},
      optional = {},
      description = '{}',
    }},
  ]], {
    i(1, 'name'),
    c(2, {
      t('string'),
      t('number'),
      t('list'),
    }),
    i(3, '\'\''),
    c(4, { t('true'), t('false'), }),
    i(0, 'none'),
  })
end

local function params()
  return fmt([[
    params = {{
      {}
    }},
  ]], {
    isn(1, param(), '$PARENT_INDENT  '),
  })
end

local cmd = dwrap([[
    cmd = {},
    cwd = vim.fn.getcwd(),
  ]], {
  c(1, {
    sn(nil, { t('\''), i(1, 'echo kill it'), t('\''), }),
    sn(nil, { t('{ \''), i(1, 'echo kill it'), t('\', }'), }),
  }),
})

local deps = dwrap([[
    {{
      'dependencies',
      seqential = {},
      task_names = {{
        '{}',
      }},
    }},
  ]], {
  c(1, { t('true'), t('false'), }),
  i(2, 'build'),
})

local orchestrator = dwrap([[
    strategy = {{
    'orchestrator',
    tasks = {{
    '{}',
    }},
    }},
  ]], {
  i(1, 'build'),
})

local function run()
  return fmt([[
    overseer.run_template({{ name = '{}' }}{})
  ]], {
    i(1),
    c(2, {
      t(''),
      sn(nil, { t(', { '), i(1), t(' }'), }),
    }),
  })
end

local function register()
  return fmt([[
    overseer.register_template({{
      name = '{}',{}
      builder = function()
        return {{
          name = '{}',{}
          components = {{
            'default',{}
          }},
        }}
      end
    }})
  ]], {
    i(1),
    c(2, {
      t(''),
      isn(nil, params(), '  '),
    }),
    f(function(a) return a[1] end, 1),
    c(3, {
      t(''),
      isn(nil, cmd(), '      '),
      isn(nil, orchestrator(), '      '),
    }),
    c(4, {
      t(''),
      isn(nil, deps(), '        '),
    }),
  })
end

local function orwp()
  return fmt([[
    overseer.register_template(
      overseer.wrap_template({}, {}, {{ {} }})
    )
  ]], {
    i(1),
    c(2, {
      t('nil'),
      sn(nil, { t('{ name = \''), i(1), t('\', }'), }),
    }),
    i(0),
  })
end

local function vins()
  return {
    t('print(vim.inspect('), i(1), t('))'),
  }
end

return {
  s('oregister', register()),
  s('orun', run()),
  s('oparam', param(true)),
  s('odeps', deps(true)),
  s('orequire', { t([[local overseer = require('overseer')]]), }),
  s('orwp', orwp()),
  s('vins', vins()),
}
