return {
  {
    -- preview_typst
    'chomosuke/typst-preview.nvim',
    lazy = false, -- or ft = 'typst'
    version = '1.*',
    opts = {}, -- lazy.nvim will implicitly calls `setup {}`
  },

  -- goto_preview
  {
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
      -- nnoremap gpd <cmd>lua require('goto-preview').goto_preview_definition()<CR>
      -- vim.keymap.set("n", "gp", "<cmd>lua require('goto-preview').goto_preview_definition()<CR>", {noremap=true})
    end,
  },

  {
    -- markdown preview
    'iamcco/markdown-preview.nvim',
    cmd = { 'MarkdownPreviewToggle', 'MarkdownPreview', 'MarkdownPreviewStop' },
    ft = { 'markdown' },
    build = function()
      vim.fn['mkdp#util#install']()
    end,
  },
}
