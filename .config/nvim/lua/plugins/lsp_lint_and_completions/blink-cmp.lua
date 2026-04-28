return {
  {
    'saghen/blink.cmp',

    dependencies = {
      'rafamadriz/friendly-snippets',
      'saghen/blink.compat',
      { 'Exafunction/codeium.nvim', opts = {} },
    },

    version = '1.*',

    ---@module 'blink.cmp'
    ---@type blink.cmp.Config
    opts = {
      keymap = { preset = 'default' },

      appearance = {
        nerd_font_variant = 'mono',
      },

      completion = { documentation = { auto_show = false } },

      sources = {
        default = { 'lsp', 'path', 'snippets', 'buffer', 'codeium' },
        providers = {
          codeium = {
            name = 'codeium',
            module = 'blink.compat.source',
            score_offset = 100, -- Prioritize AI suggestions
            async = true,
          },
        },
      },

      fuzzy = { implementation = 'prefer_rust_with_warning' },
    },
    opts_extend = { 'sources.default' },
  },
}
