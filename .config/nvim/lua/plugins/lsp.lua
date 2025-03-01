return {
    -- {
    --     'nvim-lua/plenary.nvim',
    -- },
    {
        'tranvansang/octave.vim',
    },
    {
        -- this wraps any warning or error message in neovim, me-likey!
        'rachartier/tiny-inline-diagnostic.nvim',
        enable = false,
        event = 'VeryLazy', -- Or `LspAttach`
        priority = 1000, -- needs to be loaded in first
        config = function()
            require('tiny-inline-diagnostic').setup()
        end,
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
        },

        opts = {},
        config = function()
            local servers = {
                svelte = {},
                tailwindcss = {},
                dartls = {
                    settings = {
                        dart = {
                            completFunctionCalls = true,
                            showTodos = true,
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
            }

            local capabilities = vim.lsp.protocol.make_client_capabilities()
            -- capabilities = vim.tbl_deep_extend('force', capabilities, require('cmp_nvim_lsp').default_capabilities())

            local lspconfig = require('lspconfig')

            -- if capabilities ~= nil then
            --     capabilities.workspace.semanticTokens.refreshSupport = false
            -- end

            -- local default_setup = function(server)
            --     lspconfig[server].setup({
            --         capabilities = capabilities,
            --     })
            -- end

            require('mason').setup({})
            local ensure_installed = vim.tbl_keys(servers or {})
            vim.list_extend(ensure_installed, {
                'stylua', -- Used to format Lua code
            })
            require('mason-tool-installer').setup({
                ensure_installed = ensure_installed,
            })
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

            -- vim.keymap('gd', require('telescope.builtin').lsp_definitions, '[G]oto [D]efinition')
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
                    -- these will be buffer-local keybindings
                    -- because they only work if you have an active language server
                    vim.keymap.set('n', 'K', function()
                        vim.lsp.buf.hover({ border = 'double' })
                    end, { desc = 'Show Hover Docs', buffer = event.buf })
                    -- vim.keymap.set('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<cr>', { desc = "", buffer = event.buf })
                    -- vim.keymap.set(
                    -- 'n',
                    -- 'gd',
                    -- require('telescope.builtin').lsp_definitions,
                    -- { desc = '[D]efinitions', buffer = event.buf }
                    -- )
                    -- vim.keymap.set(
                    -- 'n',
                    -- 'gR',
                    -- require('telescope.builtin').lsp_references,
                    -- { desc = '[R]eferences', buffer = event.buf }
                    -- )
                    -- vim.keymap.set(
                    -- 'n',
                    -- 'gI',
                    -- require('telescope.builtin').lsp_implementations,
                    -- { desc = '[I]mplementations', buffer = event.buf }
                    -- )
                    vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, { desc = '[D]eclaration', buffer = event.buf })
                    vim.keymap.set(
                        'n',
                        'go',
                        vim.lsp.buf.type_definition,
                        { desc = 'Type Definition', buffer = event.buf }
                    )
                    -- vim.keymap.set('n', 'gs', '<cmd>lua vim.lsp.buf.signature_help()<cr>', { desc = "", buffer = event.buf })
                    vim.keymap.set('n', 'gr', vim.lsp.buf.rename, { desc = 'LSP [R]ename', buffer = event.buf }) -- todo change
                    -- vim.keymap.set({ 'n', 'x' }, '<leader><leader>', '<cmd>lua vim.lsp.buf.format({async = true})<cr>', { desc = "", buffer = event.buf })
                    vim.keymap.set('n', 'gC', vim.lsp.buf.code_action, { desc = '[C]ode Action', buffer = event.buf })
                    vim.keymap.set(
                        'n',
                        '<leader>i',
                        '<cmd>lua vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled())<CR>',
                        { desc = '[I]nlay Hints', buffer = event.buf }
                    )
                end,
            })

            vim.diagnostic.config({ virtual_text = false })
        end,
    },
}
