return {

    {
        'romgrk/barbar.nvim',
        dependencies = {
            'lewis6991/gitsigns.nvim', -- OPTIONAL: for git status
            'nvim-tree/nvim-web-devicons', -- OPTIONAL: for file icons
        },
        opts = { noremap = true, silent = true },

        config = function()
            local map = vim.api.nvim_set_keymap
            map('n', 'gt', '<Cmd>tabnext<CR>', { desc = 'Go to next tabpage' })
            map('n', '<leader>nt', '<Cmd>tabnext<CR>', { desc = 'Go to next tabpage' })

            map('n', 'gT', '<Cmd>tabprevious<CR>', { desc = 'Go to previous tabpage' })
            map('n', '<leader>tp', '<Cmd>tabprevious<CR>', { desc = 'Go to previous tabpage' })

            map('n', '[t', '<Cmd>tabprevious<CR>', { desc = 'Go to previous tabpage' })
            map('n', ']t', '<Cmd>tabnext<CR>', { desc = 'Go to next tabpage' })
        end,
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
