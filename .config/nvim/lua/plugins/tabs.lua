return {
    {
        'akinsho/bufferline.nvim',
        name = 'bufferline',
        version = '*',
        event = 'VimEnter',
        keys = {
            { '<leader>bp', '<Cmd>BufferLineTogglePin<CR>', desc = 'Toggle Pin' },
            { '<leader>bP', '<Cmd>BufferLineGroupClose ungrouped<CR>', desc = 'Delete Non-Pinned Buffers' },
            { '<leader>bo', '<Cmd>BufferLineCloseOthers<CR>', desc = 'Delete Other Buffers' },
            { '<leader>br', '<Cmd>BufferLineCloseRight<CR>', desc = 'Delete Buffers to the Right' },
            { '<leader>bl', '<Cmd>BufferLineCloseLeft<CR>', desc = 'Delete Buffers to the Left' },
            { '<S-y>', '<cmd>BufferLineCyclePrev<cr>', desc = 'Prev Buffer' },
            { '<S-e>', '<cmd>BufferLineCycleNext<cr>', desc = 'Next Buffer' },
            { '[b', '<cmd>BufferLineCyclePrev<cr>', desc = 'Prev Buffer' },
            { ']b', '<cmd>BufferLineCycleNext<cr>', desc = 'Next Buffer' },
            { '[B', '<cmd>BufferLineMovePrev<cr>', desc = 'Move buffer prev' },
            { ']B', '<cmd>BufferLineMoveNext<cr>', desc = 'Move buffer next' },
        },
        opts = {

            separator_style = 'slant',
        },
    },
    {
        'navarasu/onedark.nvim',
        config = function()
            -- vim.cmd("colorscheme onedark")
            require('onedark').setup({
                style = 'deep',
            })
            require('onedark').load()
        end,
    },
    {
        'folke/tokyonight.nvim',
    },
    -- run this command when you load the plugin
}
