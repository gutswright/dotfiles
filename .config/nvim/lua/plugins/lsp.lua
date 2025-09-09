return {
    {
        'rachartier/tiny-inline-diagnostic.nvim',
        enable = false,
        event = 'VeryLazy', -- Or `LspAttach`
        priority = 1000, -- needs to be loaded in first
        config = function()
            require('tiny-inline-diagnostic').setup()
        end,
    },
    {
        'folke/ts-comments.nvim',
        opts = {},
        event = 'VeryLazy',
        enabled = vim.fn.has('nvim-0.10.0') == 1,
    },
    {
        'neovim/nvim-lspconfig',
        name = 'lspconfig',
        event = { 'BufReadPre', 'BufNewFile', 'VeryLazy' },
        dependencies = {
            { 'nvim-telescope/telescope.nvim' }, -- Optional for class previewer
            { 'saghen/blink.cmp' },
            { 'williamboman/mason.nvim', name = 'mason' },
            { 'williamboman/mason-lspconfig.nvim', name = 'mason-lspconfig' },
            { 'WhoIsSethDaniel/mason-tool-installer.nvim', name = 'mason-installer' },
            { 'hrsh7th/cmp-nvim-lsp' }, -- Add cmp-nvim-lsp as a dependency
            { 'hrsh7th/nvim-cmp' }, -- Add cmp-nvim-lsp as a dependency
        },

        opts = {},
        config = function()
            local capabilities = require('cmp_nvim_lsp').default_capabilities()
            local lspconfig = require('lspconfig')

            lspconfig.sourcekit.setup({
                capabilities = capabilities,
                workspace = {
                    didChangeWatchedFiles = {
                        dynamicRegistration = true,
                    },
                },
            })

            local servers = {
                ruff = {},
                pyright = {},
                svelte = {},
                tailwindcss = {},
                kotlin_language_server = {},
                matlab_ls = {
                    filetypes = { 'matlab' },
                    settings = {
                        MATLAB = {
                            indexWorkspace = true,
                            installPath = '/usr/local/MATLAB/R2024b/', -- Optional: set the path to your MATLAB installation
                            matlabConnectionTiming = 'onStart',
                            telemetry = false,
                        },
                    },
                },
                tinymist = {
                    root_dir = function(_, bufnr)
                        return vim.fn.expand('%:p:h')
                    end,
                    on_init = function(client, _)
                        client.server_capabilities.semanticTokensProvider = nil
                        client.settings = {
                            root_dir = function(_, bufnr)
                                return vim.fn.expand('%:p:h')
                            end,
                        }
                    end,
                    settings = {
                        formatterMode = 'typstyle',
                        outputPath = '$root/$dir/$name',
                        exportPdf = 'onType',
                    },
                },
                lua_ls = {
                    settings = {
                        Lua = {
                            format = {
                                enable = true,
                                defaultConfig = {
                                    indent_style = 'space',
                                    indent_size = '4',
                                },
                            },
                            runtime = {
                                version = 'LuaJIT',
                            },
                            diagnostics = {
                                globals = { 'vim' },
                                disable = { 'missing-fields' },
                            },
                            workspace = {
                                checkThirdParty = false,
                                libary = {
                                    vim.env.VIMRUNTIME,
                                },
                            },
                            telemetry = {
                                enable = false,
                            },
                            hint = { enable = true },
                        },
                    },
                },
                -- swift_lsp = {}, -- Add swift_lsp to the servers table
            }

            require('mason').setup({})
            local ensure_installed = vim.tbl_keys(servers or {})
            vim.list_extend(ensure_installed, { 'stylua' })
            require('mason-tool-installer').setup({ ensure_installed = ensure_installed })
            require('mason-lspconfig').setup({
                handlers = {
                    function(server_name)
                        local server = servers[server_name] or {}
                        capabilities = vim.tbl_deep_extend(
                            'force',
                            capabilities,
                            require('blink.cmp').get_lsp_capabilities(server.capabilities)
                        )
                        server.capabilities = vim.tbl_deep_extend('force', {}, capabilities, server.capabilities or {})
                        lspconfig[server_name].setup(server)
                    end,
                },
            })

            vim.cmd(
                [[sign define DiagnosticSignError text= texthl=DiagnosticSignError linehl= numhl=DiagnosticSignError]]
            )
            vim.cmd(
                [[sign define DiagnosticSignWarn text= texthl=DiagnosticSignWarn linehl= numhl=DiagnosticSignWarn]]
            )
            vim.cmd(
                [[sign define DiagnosticSignInfo text= texthl=DiagnosticSignInfo linehl= numhl=DiagnosticSignInfo]]
            )
            vim.cmd(
                [[sign define DiagnosticSignHint text= texthl=DiagnosticSignHint linehl= numhl=DiagnosticSignHint ]]
            )

            vim.api.nvim_create_autocmd('LspAttach', {
                desc = 'LSP actions',
                callback = function(event)
                    local buffer = event.buf
                    vim.keymap.set('n', 'K', function()
                        vim.lsp.buf.hover({ border = 'double' })
                    end, { desc = 'Show Hover Docs', buffer = buffer })
                    vim.keymap.set('n', 'gd', vim.lsp.buf.definition, { desc = '[G]oto [D]efinition', buffer = buffer })
                    vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, { desc = '[D]eclaration', buffer = buffer })
                    vim.keymap.set(
                        'n',
                        'go',
                        vim.lsp.buf.type_definition,
                        { desc = 'Type Definition', buffer = buffer }
                    )
                    vim.keymap.set('n', 'gr', vim.lsp.buf.rename, { desc = 'LSP [R]ename', buffer = buffer })
                    vim.keymap.set('n', 'gC', vim.lsp.buf.code_action, { desc = '[C]ode Action', buffer = buffer })
                    vim.keymap.set(
                        'n',
                        '<leader>i',
                        '<cmd>lua vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled())<CR>',
                        { desc = '[I]nlay Hints', buffer = buffer }
                    )
                end,
            })

            -- Update diagnostic config to use new sign configuration
            vim.diagnostic.config({ 
                virtual_text = false,
                signs = {
                    text = {
                        [vim.diagnostic.severity.ERROR] = "",
                        [vim.diagnostic.severity.WARN] = "",
                        [vim.diagnostic.severity.HINT] = "",
                        [vim.diagnostic.severity.INFO] = "",
                    },
                },
            })
        end,
    },
    { 'hrsh7th/cmp-buffer', lazy = true },
    { 'hrsh7th/cmp-path', lazy = true },
}
