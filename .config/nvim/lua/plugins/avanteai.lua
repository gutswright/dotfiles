return {
    {
        'yetone/avante.nvim',
        event = 'VeryLazy',
        version = false, -- Never set this value to "*"! Never!
        opts = {
            -- add any opts here
            -- for example
            provider = 'gemini',
            providers = {
                openai = {
                    endpoint = 'https://api.openai.com/v1',
                    model = 'gpt-4o', -- your desired model (or use gpt-4o, etc.)
                    extra_request_body = {
                        timeout = 30000, -- Timeout in milliseconds, increase this for reasoning models
                        temperature = 0.75,
                        max_completion_tokens = 8192, -- Increase this to include reasoning tokens (for reasoning models)
                        --reasoning_effort = "medium", -- low|medium|high, only used for reasoning models
                    },
                },
                gemini = {
                    endpoint = 'https://generativelanguage.googleapis.com/v1beta/models',
                    model = 'gemini-2.0-flash',
                    timeout = 30000, -- Timeout in milliseconds
                    use_ReAct_prompt = true,
                    extra_request_body = {
                        generationConfig = {
                            temperature = 0.75,
                        },
                    },
                },
            },
            behaviour = {
                auto_set_keymaps = false,
            },
        },
        build = 'make',
        -- build = "powershell -ExecutionPolicy Bypass -File Build.ps1 -BuildFromSource false" -- for windows
        dependencies = {
            'nvim-treesitter/nvim-treesitter',
            'nvim-lua/plenary.nvim',
            'MunifTanjim/nui.nvim',
            --- The below dependencies are optional,
            'echasnovski/mini.pick', -- for file_selector provider mini.pick
            'nvim-telescope/telescope.nvim', -- for file_selector provider telescope
            'hrsh7th/nvim-cmp', -- autocompletion for avante commands and mentions
            'ibhagwan/fzf-lua', -- for file_selector provider fzf
            'stevearc/dressing.nvim', -- for input provider dressing
            'folke/snacks.nvim', -- for input provider snacks
            'nvim-tree/nvim-web-devicons', -- or echasnovski/mini.icons
            'zbirenbaum/copilot.lua', -- for providers='copilot'
            {
                -- support for image pasting
                'HakonHarnes/img-clip.nvim',
                event = 'VeryLazy',
                opts = {
                    -- recommended settings
                    default = {
                        embed_image_as_base64 = false,
                        prompt_for_file_name = false,
                        drag_and_drop = {
                            insert_mode = true,
                        },
                        -- required for Windows users
                        use_absolute_path = true,
                    },
                },
            },
            {
                'MeanderingProgrammer/render-markdown.nvim',
                opts = {
                    file_types = { 'Avante' },
                },
                ft = { 'Avante' },
            },
        },
    },
}
