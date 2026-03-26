return {
  {
    'navarasu/onedark.nvim',
    -- priority = 1000,
    config = function()
      -- vim.cmd("colorscheme onedark")
      require('onedark').setup({
        style = 'deep',
        highlights = {
          ['@comment'] = { fg = '#A0A0A0', fmt = 'italic' },

          ['@keyword.export'] = { fg = '#e06c75' },

          ['@keyword.coroutine'] = { fg = '#56b6c2' },

          ['@keyword.function'] = { fg = '#efbd5d', fmt = 'italic' },

          ['@keyword.return'] = { fg = '#c678dd', fmt = 'italic' },
          ['@variable.parameter'] = { fmt = 'bold,italic' },
          ['@variable.member'] = { fg = '#e88dca', fmt = 'bold,italic' },
          -- ['@variable'] = { fg = '#bab1af' },
        },
      })
      require('onedark').load()

      vim.g.comments_on = true
      vim.keymap.set('n', '<leader>cc', function()
        if vim.g.comments_on then
          vim.api.nvim_set_hl(0, '@comment', { fg = '#455574', italic = true })
          vim.g.comments_on = false
        else
          vim.api.nvim_set_hl(0, '@comment', { fg = '#A0A0A0', italic = true })
          vim.g.comments_on = true
        end
      end, { noremap = true, silent = true, desc = 'Toggle comment color' })
    end,
  },
  -- {
  -- 'folke/tokyonight.nvim',
  -- },
  -- { "catppuccin/nvim", name = "catppuccin", priority = 1000 }
}
