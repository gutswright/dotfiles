return {
    {
        'navarasu/onedark.nvim',
        config = function()
            -- vim.cmd("colorscheme onedark")
            require('onedark').setup({
                style = 'deep',
                highlights = {
                    Comment = { fg = '#7aa2f7' },
                },
            })
            require('onedark').load()
        end,
    },
    {
        'folke/tokyonight.nvim',
    },
}
