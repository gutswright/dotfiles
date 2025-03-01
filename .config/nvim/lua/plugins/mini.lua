-- =ip to format stuff
return {
    {
        'echasnovski/mini.nvim',
        version = false,
        config = function() -- We are setting up a plugin spec
            -- (config is a key-value pair for lazy)
            -- this function is ran whenever the plugin is loaded
            require('mini.files').setup({})
            vim.keymap.set('n', '<leader>e', function()
                MiniFiles.open()
            end, { desc = 'Open mini file finder' })
            require('mini.colors').setup({})
            require('mini.comment').setup({})
            require('mini.ai').setup({})
            vim.api.nvim_create_autocmd('Filetype', {
                pattern = 'dart',
                callback = function()
                    vim.bo.commentstring = '// %s'
                end,
            })

            require('mini.cursorword').setup({}) -- underlines all the same words in the file

            local hipatterns = require('mini.hipatterns')
            hipatterns.setup({
                highlighters = {
                    fixme = { pattern = '%f[%w]()FIXME()%f[%W]', group = 'MiniHipatternsFixme' },
                    hack = { pattern = '%f[%w]()HACK()%f[%W]', group = 'MiniHipatternsHack' },
                    todo = { pattern = '%f[%w]()TODO()%f[%W]', group = 'MiniHipatternsTodo' },
                    note = { pattern = '%f[%w]()NOTE()%f[%W]', group = 'MiniHipatternsNote' },
                    cool = { pattern = '%f[%w]()COOL()%f[%W]', group = 'debugPC' },
                    dope = { pattern = '%f[%w]()DOPE()%f[%W]', group = 'ToolbarButton' },
                    nice = { pattern = '%f[%w]()NICE()%f[%W]', group = 'Nice' },

                    hex_color = require('mini.hipatterns').gen_highlighter.hex_color(),
                },
            })
            vim.api.nvim_set_hl(0, 'Nice', { bg = '#e8e031', fg = '#2399ff', bold = true })

            local MiniMap = require('mini.map')
            MiniMap.setup({
                symbols = { encode = MiniMap.gen_encode_symbols.dot('4x2'), scroll_view = ' ', scroll_line = '▶' },

                integrations = {
                    MiniMap.gen_integration.diagnostic({
                        error = 'DiagnosticFloatingError',
                        warn = 'DiagnosticFloatingWarn',
                        info = 'DiagnosticFloatingInfo',
                        hint = 'DiagnosticFloatingHint',
                    }),
                },
                window = {
                    width = 10,
                    winblend = 90,
                    show_integration_count = false,
                },
            })
            vim.keymap.set('n', '<Leader>mf', MiniMap.toggle_focus)
            vim.keymap.set('n', '<Leader>ms', MiniMap.toggle_side)
            vim.keymap.set('n', '<Leader>mt', MiniMap.toggle)
        end,
    },
}
