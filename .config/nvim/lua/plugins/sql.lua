return {
  'kristijanhusak/vim-dadbod-ui',
  dependencies = {
    { 'tpope/vim-dadbod', lazy = true },
    { 'kristijanhusak/vim-dadbod-completion', ft = { 'sql', 'mysql', 'plsql' }, lazy = true }, -- Optional
  },
  cmd = {
    'DBUI',
    'DBUIToggle',
    'DBUIAddConnection',
    'DBUIFindBuffer',
  },
  init = function()
    -- Your DBUI configuration
    vim.g.db_ui_use_nerd_fonts = 1
  end,

  -- vim.api.nvim_create_user_command('DBUIToXan', function()
  --   -- Get the current buffer content and pipe to xan
  --   vim.cmd([[
  --     %y | new | put | 1d | %!xan view --rainbow
  --   ]])
  -- end, {}),

  keys = {
    { '<leader>dbo', '<cmd>DBUI<CR>', desc = 'Open DBUI' },
    { '<leader>dbt', '<cmd>DBUIToggle<CR>', desc = 'Toggle DBUI' },
    { '<leader>dbw', '<cmd>DBUI_SaveQuery<CR>', desc = '"Write the query to the db"'},
    -- { '<leader>dbac', '<cmd>DBUIAddConnection<CR>', desc = 'DBUI Add Connection' },
    { '<leader>dbfb', '<cmd>DBUIFindBuffer<CR>', desc = 'DBUI Find Buffer' },
    -- {'n', '<leader>dbx', '<cmd>DBUIToXan<CR>', desc = 'View current buffer with xan colors'},
  }
}

-- return {
--     'tpope/vim-dadbod',
--     'kristijanhusak/vim-dadbod-completion',
--     'kristijanhusak/vim-dadbod-ui',
-- }
