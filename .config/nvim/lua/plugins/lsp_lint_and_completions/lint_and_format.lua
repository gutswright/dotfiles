return {
  {
    'WhoIsSethDaniel/mason-tool-installer.nvim',
    config = function()
      require('mason-tool-installer').setup({
        ensure_installed = {
          'lua_ls',
          'vale-ls',
          'ruff',
          'tflint',
          'stylua',
          'eslint_d',
          'stylelint',
          'debugpy',
          'terraform',
        },
      })
    end,
  },
  {
    'mfussenegger/nvim-lint',
    config = function()
      require('lint').linters_by_ft = {
        markdown = { 'vale' },
        python = { 'ruff' },
        tf = { 'tflint' },
        svelte = { 'eslint' },
        javascript = { 'eslint' },
        typescript = { 'eslint' },
        -- css = { 'stylelint' },
      }
    end,
  },
  {
    'stevearc/conform.nvim',
    config = function()
      require('conform').setup({
        formatters_by_ft = {
          lua = { 'stylua' },
          python = { 'ruff' },
          javascript = { 'prettierd', 'prettier', stop_after_first = true },
          typescript = { 'prettierd', 'prettier', stop_after_first = true },
          svelte = { 'prettierd', 'prettier', stop_after_first = true },
          html = { 'prettierd', 'prettier', stop_after_first = true },
          -- css = { 'prettierd', 'prettier', stop_after_first = true },
          hcl = { 'terraform_fmt' },
          tf = { 'terraform_fmt' },
          taplo = { 'toml' },
          fish = { 'fish_indent' },
          sh = { 'shfmt' },
        },
        formatters = {
          stylua = {
            prepend_args = { '--indent-type', 'Spaces', '--indent-width', '2' },
          },
        },
        format_on_save = {
          timeout_ms = 500,
          lsp_format = 'fallback',
        },
      })
    end,
  },
}

-- ◍ debugpy
--     ◍ eslint-lsp eslint
--     ◍ eslint_d
--     ◍ kotlin-language-server kotlin_language_server
--     ◍ lua-language-server lua_ls
--     ◍ matlab-language-server matlab_ls
--     ◍ prettier
--     ◍ ruff
--     ◍ shfmt
--     ◍ stylelint
--     ◍ stylua
--     ◍ svelte-language-server svelte
--     ◍ tailwindcss-language-server tailwindcss
--     ◍ taplo
--     ◍ terraform
--     ◍ terraform-ls terraformls
--     ◍ tflint
--     ◍ tinymist
--     ◍ vale-ls vale_ls
