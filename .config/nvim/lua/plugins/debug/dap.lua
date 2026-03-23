return {
    {
        'mfussenegger/nvim-dap',
        dependencies = {
            'nvim-neotest/nvim-nio',
            'rcarriga/nvim-dap-ui',
            'mfussenegger/nvim-dap-python',
            'theHamsta/nvim-dap-virtual-text',
        },
        config = function()
            local dap = require('dap')
            local dapui = require('dapui')
            local dap_python = require('dap-python')

            require('dapui').setup({})
            require('nvim-dap-virtual-text').setup({
                commented = true,
            })

            -- Setup Python debugging with uv
            -- First setup the basic Python adapter
            dap_python.setup('python')

            -- Override the Python adapter to use uv run
            dap.adapters.python = {
                type = 'executable',
                command = 'uv',
                args = { 'run', 'python', '-m', 'debugpy.adapter' },
            }

            vim.fn.sign_define('DapBreakPoint', {
                text = '0',
                texthe = 'DiagnosticSignError',
                linehl = '',
                numhl = '',
            })

            vim.fn.sign_define('DapBreakPointRejected', {
                text = 'X',
                texthe = 'DiagnosticSignError',
                linehl = '',
                numhl = '',
            })

            vim.fn.sign_define('DapStopped', {
                text = 'Z',
                texthe = 'DiagnosticSignWar',
                linehl = 'Visual',
                numhl = 'DiagnosticSignWarn',
            })

            dap.listeners.after.event_initialized['dapui_config'] = function()
                dapui.open()
            end

            local opts = { noremap = true, silent = true }

            vim.keymap.set('n', '<Leader>dp', function()
                dap.toggle_breakpoint()
            end, opts)

            vim.keymap.set('n', '<BS>c', function()
                dap.continue()
            end, opts)

            vim.keymap.set('n', '<Leader>do', function()
                dap.step_over()
            end, opts)

            vim.keymap.set('n', '<Leader>di', function()
                dap.step_into()
            end, opts)

            vim.keymap.set('n', '<Leader>do', function()
                dap.step_out()
            end, opts)

            vim.keymap.set('n', '<leader>dq', function()
                require('dap').terminate()
            end, opts)

            vim.keymap.set('n', '<Leader>du', function()
                dapui.toggle()
            end, opts)
        end,
    },
}
