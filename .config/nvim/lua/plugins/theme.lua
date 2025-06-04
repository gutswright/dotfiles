return {
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
