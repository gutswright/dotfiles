vim.lsp.config('ruff', {
  on_attach = function(client, bufnr)
    client.server_capabilities.hoverProvider = false

    if client.supports_method('textDocument/formatting') then
      vim.api.nvim_create_autocmd('BufWritePre', {
        buffer = bufnr,
        callback = function()
          vim.lsp.buf.format({ bufnr = bufnr, async = false })
        end,
      })
    end
  end,
})

vim.lsp.enable('ruff')
