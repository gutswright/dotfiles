return {
  {
    'williamboman/mason.nvim',
    config = function()
      require('mason').setup()
    end,
  },
  {
    'williamboman/mason-lspconfig.nvim',
    config = function()
      require('mason-lspconfig').setup({
        ensure_installed = {
          'lua_ls',
          'pyright',
          -- 'basedpyright',
          'svelte',
          'terraformls',
          'cssls',
          'tailwindcss',
        },
      })
    end,
  },
  {
    'neovim/nvim-lspconfig',
    config = function()
      vim.lsp.config('lua_ls', {})
      vim.lsp.config('svelte', {})
      vim.lsp.config('terraformls', {})
      vim.lsp.config('cssls', {})
      vim.lsp.config('tailwindcss', {})

      vim.keymap.set('n', 'K', vim.lsp.buf.hover, {})
      vim.keymap.set('n', 'gd', vim.lsp.buf.definition)
      vim.keymap.set('n', 'gr', vim.lsp.buf.references)
      vim.keymap.set({ 'n', 'v' }, '<leader>ca', vim.lsp.buf.code_action)
      vim.api.nvim_set_hl(0, '@lsp.type.comment', {})
    end,
  },
  {
    'rachartier/tiny-inline-diagnostic.nvim',
    event = 'VeryLazy',
    priority = 1000,
    config = function()
      require('tiny-inline-diagnostic').setup()
      vim.diagnostic.config({ virtual_text = false })
    end,
  },
}
