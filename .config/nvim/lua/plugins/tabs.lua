return {

    {
        'nvim-tree/nvim-web-devicons',
    },
    -- {
    --     'romgrk/barbar.nvim',
    --     dependencies = {
    --         'lewis6991/gitsigns.nvim', -- OPTIONAL: for git status
    --         'nvim-tree/nvim-web-devicons', -- OPTIONAL: for file icons
    --     },
    --     init = function()
    --         vim.g.barbar_auto_setup = false
    --     end,
    --     opts = {
    --         -- Your custom options go here.
    --         -- WARN: do not copy everything from the example; pick what you need.
    --         animation = true,
    --         auto_hide = false,
    --         clickable = true,
    --         icons = {
    --             buffer_index = true, -- Show buffer index
    --             buffer_number = false,
    --             button = '',
    --             diagnostics = {
    --                 [vim.diagnostic.severity.ERROR] = { enabled = true, icon = 'ﬀ' },
    --                 [vim.diagnostic.severity.WARN] = { enabled = true, icon = '' }, -- Example: enable warnings
    --             },
    --             filetype = {
    --                 custom_colors = false,
    --                 enabled = true,
    --             },
    --             separator = { left = '▎', right = '' },
    --             modified = { button = '●' },
    --             pinned = { button = '', filename = true },
    --             current = { buffer_index = true }, -- Show index for current buffer
    --         },
    --         maximum_padding = 1,
    --         minimum_padding = 1,
    --         maximum_length = 30,
    --         letters = 'nrtsgyhaeibldwz\'foujqxmcvk.-/NRTSGYHAEIBLDWZ_FOUJQXMCVK>"<',
    --     },
    --     version = '^1.0.0',
    --     config = function()
    --         require('barbar').setup(require('barbar').opts or {})
    --
    --         local map = vim.api.nvim_set_keymap
    --         local opts = { noremap = true, silent = true }
    --         -- Example for your init.lua or similar
    --         vim.api.nvim_set_keymap('n', '<BS>0', '<Cmd>BufferGoto 1<CR>', { noremap = true, silent = true })
    --         vim.api.nvim_set_keymap('n', '<BS>1', '<Cmd>BufferGoto 2<CR>', { noremap = true, silent = true })
    --         vim.api.nvim_set_keymap('n', '<BS>2', '<Cmd>BufferGoto 3<CR>', { noremap = true, silent = true })
    --         vim.api.nvim_set_keymap('n', '<BS>3', '<Cmd>BufferGoto 4<CR>', { noremap = true, silent = true })
    --         vim.api.nvim_set_keymap('n', '<BS>4', '<Cmd>BufferGoto 5<CR>', { noremap = true, silent = true })
    --         vim.api.nvim_set_keymap('n', '<BS>5', '<Cmd>BufferGoto 6<CR>', { noremap = true, silent = true })
    --         vim.api.nvim_set_keymap('n', '<BS>6', '<Cmd>BufferGoto 7<CR>', { noremap = true, silent = true })
    --         vim.api.nvim_set_keymap('n', '<BS>7', '<Cmd>BufferGoto 8<CR>', { noremap = true, silent = true })
    --         vim.api.nvim_set_keymap('n', '<BS>8', '<Cmd>BufferGoto 9<CR>', { noremap = true, silent = true })
    --
    --         vim.api.nvim_set_keymap(
    --             'n',
    --             '<BS>tr',
    --             '<Cmd>BufferNext<CR>',
    --             { noremap = true, silent = true, desc = 'Tab right (next)' }
    --         )
    --
    --         vim.api.nvim_set_keymap(
    --             'n',
    --             '<BS>tl',
    --             '<Cmd>BufferNext<CR>',
    --             { noremap = true, silent = true, desc = 'Tab left (previous)' }
    --         )
    --
    --         vim.api.nvim_set_keymap(
    --             'n',
    --             '<BS>ts',
    --             '<Cmd>BufferPick<CR>',
    --             { noremap = true, silent = true, desc = 'Pick a tab to select (switch)' }
    --         )
    --         vim.api.nvim_set_keymap(
    --             'n',
    --             '<BS>tc',
    --             '<Cmd>BufferClose<CR>',
    --             { noremap = true, silent = true, desc = 'Close current tabpage' }
    --         )
    --         vim.api.nvim_set_keymap(
    --             'n',
    --             '<BS>tx',
    --             '<Cmd>BufferPickDelete<CR>',
    --             { noremap = true, silent = true, desc = 'Select tabs to be deleted' }
    --         )
    --         vim.api.nvim_set_keymap(
    --             'n',
    --             '<BS>tr',
    --             '<Cmd>BufferRestore<CR>',
    --             { noremap = true, silent = true, desc = 'Restore the last closed Buffer' }
    --         )
    --         vim.api.nvim_set_keymap(
    --             'n',
    --             '<BS>tz',
    --             '<Cmd>BufferPin<CR>',
    --             { noremap = true, silent = true, desc = 'Pins Buffer' }
    --         )
    --         vim.api.nvim_set_keymap(
    --             'n',
    --             '<BS>tb',
    --             '<Cmd>BufferCloseAllButPinned<CR>',
    --             { noremap = true, silent = true, desc = 'Close all tabs but pinned' }
    --         )
    --         vim.api.nvim_set_keymap(
    --             'n',
    --             '<BS>tq',
    --             '<Cmd>BufferCloseAllButCurrent<CR>',
    --             { noremap = true, silent = true, desc = 'Close all tabs but current' }
    --         )
    --     end,
    -- },
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
}
