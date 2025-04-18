return {
    'nvim-flutter/flutter-tools.nvim',
    lazy = false,
    dependencies = {
        'nvim-lua/plenary.nvim',
        'stevearc/dressing.nvim', -- optional for vim.ui.select
    },
    config = function()
        require('flutter-tools').setup({
            ui = {
                border = 'rounded', -- Rounded borders for popups
            },
            closing_tags = {
                highlight = 'errorMsg',
            },
            lsp = {
                color = {
                    enabled = true,
                    background = false, -- highlight the background
                    background_color = nil, -- required, when background is transparent (i.e. background_color = { r = 19, g = 17, b = 24},)
                    foreground = false, -- highlight the foreground
                    virtual_text = true, -- show the highlight using virtual text
                    virtual_text_str = '■', -- the virtual text character to highlight
                },
                settings = {
                    showTodos = true,
                    completeFunctionCalls = true,
                    analysisExcludedFolders = { '<path-to-flutter-sdk-packages>' },
                },
            },
            widget_guides = {
                enabled = true, -- Enable widget guides (experimental)
            },
            dev_log = {
                enabled = true, -- Enable the developer log
                open_cmd = '15split', -- Command to open the log buffer
            },
        })
    end,
}
