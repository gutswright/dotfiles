return {
    {
        'daeyun/vim-matlab',
        config = function()
            vim.g.matlab_auto_mappings = 1
            vim.g.matlab_server_launcher = 'vim'
            vim.g.matlab_server_split = 'vertical'
        end,
    },
}
