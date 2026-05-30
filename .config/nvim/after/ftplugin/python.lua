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

-- Run the current file on save and print output to terminal on right of screen
vim.api.nvim_create_autocmd('BufWritePost', {
  buffer = 0,
  callback = function()
    local file = vim.fn.expand('%:p')
    for _, buf in ipairs(vim.api.nvim_list_bufs()) do
      if vim.b[buf].is_run_buf then
        vim.api.nvim_buf_delete(buf, { force = true })
      end
    end
    -- vim.cmd('botright split | resize 15')
    vim.cmd('botright vsplit | vertical resize 60')
    vim.cmd('terminal uv run ' .. file)
    vim.b.is_run_buf = true
    vim.cmd('wincmd p')
  end,
})

vim.opt_local.wrap = false
