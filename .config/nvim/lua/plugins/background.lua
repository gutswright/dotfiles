return {
    {
        'xiyaowong/transparent.nvim',
        lazy = false,
        config = function()
            require('transparent').setup({
                extra_groups = {
                    'NormalFloat',
                    'NvimTreeNormal',
                },
            })
        end,
    },
    {
        'folke/tokyonight.nvim',
        priority = 1000,
        init = function()
            vim.cmd.colorscheme('tokyonight-night')

            vim.cmd.hi('Comment gui=none')
        end,
    },
}
