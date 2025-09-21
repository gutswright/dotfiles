return {
    {
        'windwp/nvim-autopairs',
        event = 'InsertEnter',
        config = true,
        -- use opts = {} for passing setup options
        -- this is equivalent to setup({}) function
    },
    {
        'stevearc/conform.nvim',
        name = 'conform',
        event = { 'BufReadPre', 'BufNewFile' },
        config = function()
            local conform = require('conform')

            conform.setup({
                formatters_by_ft = {
                    awk = { 'awk' },
                    lua = { 'stylua' },
                    python = { 'ruff_format', 'ruff_organize_imports' },
                    go = { 'gofumpt' },
                    -- svelte = { { "prettierd", "prettier" } },
                    javascript = { 'prettierd' },
                    -- typescript = { { "prettierd", "prettier" } },
                    -- javascriptreact = { { "prettierd", "prettier" } },
                    -- typescriptreact = { { "prettierd", "prettier" } },
                    json = { 'prettierd' },
                    jsonc = { 'prettierd' },
                    typst = { 'typstfmt' },
                    html = { 'prettierd' },
                    bash = { 'beautysh' },
                    sh = { 'shfmt' },
                    zsh = { 'beautysh' },
                    rust = { 'rustfmt', lsp_format = 'fallback' },
                    yaml = { 'prettierd' },
                    toml = { 'taplo' },
                    css = { 'prettierd' },
                    scss = { 'prettierd' },
                    svelte = { 'prettierd' },
                },
                format_after_save = {
                    async = true,
                    lsp_fallback = true,
                },
            })
        end,
    },
}
