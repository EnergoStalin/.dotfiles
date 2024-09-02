---@diagnostic disable: undefined-global

local function param()
  return fmt([[
  {} = {{
    type = '{}',
    default = {},
    optional = {},
    description = '{}',
  }},
  ]], {
    i(1),
    c(2, {
      t('string'),
      t('number'),
      t('list'),
    }),
    i(3),
    c(4, { t('true'), t('false'), }),
    i(0),
  })
end

local function params()
  return fmt([[
  {},
  params = {{
    {}
  }},
  ]], {
    t(''),
    sn(1, param()),
  })
end

local function cmd()
  return fmt([[
  cmd = {},
  cwd = vim.fn.getcwd(),
  ]], {
    c(1, {
      sn(nil, { t('\''), i(1), t('\''), }),
      sn(nil, { t('{ \''), i(1), t('\', }'), }),
    }),
  })
end

local function deps()
  return fmt([[
  {{
    'dependencies',
    seqential = {},
    task_names = {{
      {},
    }},
  }},
  ]], {
    c(1, { t('true'), t('false'), }),
    i(0),
  })
end

local function orchestrator()
  return fmt([[
  ,
  strategy = {{
    'orchestrator',
    tasks = {{
      {}
    }},
  }},
  ]], {
    i(0),
  })
end

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
    name = '{}'{}
    builder = function()
      return {{
        name = '{}'{}
        components = {{
          'default',{}
        }},
      }}
    end
  }})
  ]], {
    i(1),
    c(2, {
      t(','),
      sn(nil, params()),
    }),
    f(function(a) return a[1] end, 1),
    c(3, {
      t(','),
      sn(nil, cmd()),
      sn(nil, orchestrator()),
    }),
    c(4, {
      t(''),
      sn(nil, deps()),
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
      sn(nil, { t('{ name = \''), i(1), t('\', }') }),
    }),
    i(0),
  })
end

return {
  s('oregister', register()),
  s('orun', run()),
  s('oparam', param()),
  s('odeps', deps()),
  s('orequire', { t([[local overseer = require('overseer')]]) }),
  s('orwp', orwp()),
}
