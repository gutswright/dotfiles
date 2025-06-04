return {
    { -- vscode style tab to show buffers
        'akinsho/bufferline.nvim',
        dependencies = {
            'lewis6991/gitsigns.nvim', -- OPTIONAL: for git status
            'nvim-tree/nvim-web-devicons', -- OPTIONAL: for file icons
        },

        name = 'bufferline',
        version = '*',
        event = 'VimEnter',
        keys = {
            { '<leader>bp', '<Cmd>BufferLineTogglePin<CR>', desc = 'Toggle Pin' },
            { '<leader>bP', '<Cmd>BufferLineGroupClose ungrouped<CR>', desc = 'Delete Non-Pinned Buffers' },
            { '<leader>bo', '<Cmd>BufferLineCloseOthers<CR>', desc = 'Delete Other Buffers' },
            { '<leader>br', '<Cmd>BufferLineCloseRight<CR>', desc = 'Delete Buffers to the Right' },
            { '<leader>bl', '<Cmd>BufferLineCloseLeft<CR>', desc = 'Delete Buffers to the Left' },
            { '<S-h>', '<cmd>BufferLineCyclePrev<cr>', desc = 'Prev Buffer' },
            { '<S-l>', '<cmd>BufferLineCycleNext<cr>', desc = 'Next Buffer' },
            { '[b', '<cmd>BufferLineCyclePrev<cr>', desc = 'Prev Buffer' },
            { ']b', '<cmd>BufferLineCycleNext<cr>', desc = 'Next Buffer' },
            { '[B', '<cmd>BufferLineMovePrev<cr>', desc = 'Move buffer prev' },
            { ']B', '<cmd>BufferLineMoveNext<cr>', desc = 'Move buffer next' },
        },
        opts = {
            options = {

                -- themable = true,
                show_close_icon = false,
                show_buffer_close_icons = false,
                indicator = {
                    style = 'underline',
                },
                close_command = function(bufnr)
                    MiniBufremove.delete(bufnr, false)
                end,
                diagnostics = 'nvim_lsp',
                always_show_bufferline = true,
                -- auto_toggle_bufferline = true,
                -- separator_style = 'thin',
                separator_style = { '', '' },
                offsets = {
                    {
                        filetype = 'neo-tree',
                        text = 'Neo-tree',
                        highlight = 'Directory',
                        text_align = 'left',
                    },
                },
            },
            highlights = {
                -- background = {
                --     -- fg = 'none',
                --     bg = {
                --         attribute = 'bg',
                --         highlight = 'Pmenu',
                --     },
                -- },
                fill = {
                    -- fg = {
                    --     attribute = 'bg',
                    --     highlight = 'Normal',
                    -- },
                    -- bg = {
                    --     attribute = 'bg',
                    --     highlight = 'Pmenu',
                    -- },
                },
            },
        },
        config = function(_, opts)
            require('bufferline').setup(opts)
            vim.cmd([[BufferLineTabRename main]])
            -- vim.cmd([[hi Pmenu guibg=none]])
        end,
    },
}
