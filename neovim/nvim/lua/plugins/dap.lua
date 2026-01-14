return {
  'mfussenegger/nvim-dap',
  dependencies = {
    'rcarriga/nvim-dap-ui',
    'theHamsta/nvim-dap-virtual-text',
    'nvim-neotest/nvim-nio',
    'mfussenegger/nvim-dap-python',
    'williamboman/mason.nvim',
  },
  config = function()
    local dap = require('dap')
    local ui = require('dapui')
    local dap_python = require('dap-python')

    require('dapui').setup({
      layouts = { {
        elements = { {
          id = 'scopes',
          size = 1
        }, {
          id = 'breakpoints',
          size = 0
        }, {
          id = 'stacks',
          size = 0
        }, {
          id = 'watches',
          size = 0
        } },
        position = 'left',
        size = 60
      }, {
        elements = { {
          id = 'repl',
          size = 0.2
        }, {
          id = 'console',
          size = 0.2
        } },
        position = 'bottom',
        size = 5
      } }
    })

    require('nvim-dap-virtual-text').setup({
      commented = true,
    })

    dap_python.setup('uv', { include_configs = false })

    vim.fn.sign_define('DapBreakpoint', { text = '', texthl = 'DiagnosticSignError', linehl = '', numhl = '' })

    vim.fn.sign_define('DapBreakpointCondition', { text = '', texthl = 'DiagnosticSignError', linehl = '', numhl = '' })
    vim.fn.sign_define('DapLogPoint', { text = '', texthl = 'DiagnosticSignError', linehl = '', numhl = '' })


    vim.fn.sign_define('DapBeakpointRejected', { text = '', texthl = 'DiagnosticSignWarn', linehl = '', numhl = '' })

    vim.fn.sign_define('DapStopped', {
      text = '→',
      texthl = 'DiagnosticSignWarn',
      linehl = 'Visual',
      numhl = 'DiagnosticSignWarn'
    })

    vim.keymap.set('n', '<leader>d\'', ui.toggle)
    vim.keymap.set('n', '<leader>do', dap.toggle_breakpoint)
    vim.keymap.set('n', '<leader>dO', function() dap.set_breakpoint(vim.fn.input('Condition: ')) end)
    vim.keymap.set('n', '<leader>d.', dap.run_to_cursor)
    vim.keymap.set('n', '<leader>d?', function() ui.eval(nil, { enter = true }) end)
    vim.keymap.set('n', '<leader>d;', function() dap.terminate() end)
    vim.keymap.set('n', '<F1>', dap.continue)
    vim.keymap.set('n', '<F2>', dap.step_into)
    vim.keymap.set('n', '<F3>', dap.step_over)
    vim.keymap.set('n', '<F4>', dap.step_out)
    vim.keymap.set('n', '<F5>', dap.step_back)
    vim.keymap.set('n', '<F6>', dap.restart)
    vim.keymap.set('n', '<F7>', dap.restart)

    local b = dap.listeners.before
    b.attach.dapui_config = ui.open
    b.launch.dapui_config = ui.open
    b.event_terminated.dapui_config = ui.close
    b.event_exited.dapui_config = ui.close
  end,
}