return {
  'rmagatti/goto-preview',
  dependencies = { 'rmagatti/logger.nvim' },
  event = 'BufEnter',
  -- config = true, -- necessary as per https://github.com/rmagatti/goto-preview/issues/88

  config = function()
    local gop = require('goto-preview')
    gop.setup({})

    vim.keymap.set('n', 'gpd', gop.goto_preview_definition, { desc = 'Go to Definition Preview' })
    vim.keymap.set('n', 'gpt', gop.goto_preview_type_definition, { desc = 'Go to Type Definition Preview' })
    vim.keymap.set('n', 'gpi', gop.goto_preview_implementation, { desc = 'Go to Implementation Preview' })
    vim.keymap.set('n', 'gpD', gop.goto_preview_declaration, { desc = 'Go to Declaration Preview' })
    vim.keymap.set('n', 'gP', gop.close_all_win, { desc = 'Close all Preview Windows' })
    vim.keymap.set('n', 'gpr', gop.goto_preview_references, { desc = 'Go to References Preview' })
  end,
}

-- nnoremap gpd <cmd>lua require('goto-preview').goto_preview_definition()<CR>
-- vim.keymap.set("n", "gp", "<cmd>lua require('goto-preview').goto_preview_definition()<CR>", {noremap=true})
