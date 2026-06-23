local lazypath = vim.fn.stdpath('data') .. '/lazy/lazy.nvim'
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = 'https://github.com/folke/lazy.nvim.git'
  local out = vim.fn.system({ 'git', 'clone', '--filter=blob:none', '--branch=stable', lazyrepo, lazypath })
  if vim.v.shell_error ~= 0 then
    vim.api.nvim_echo({
      { 'Failed to clone lazy.nvim:\n', 'ErrorMsg' },
      { out, 'WarningMsg' },
      { '\nPress any key to exit...' },
    }, true, {})
    vim.fn.getchar()
    os.exit(1)
  end
end
vim.opt.rtp:prepend(lazypath)

require('lazy').setup({
  spec = {

    require('plugins.lsp_lint_and_completions.treesitter'),
    require('plugins.lsp_lint_and_completions.lint_and_format'),
    require('plugins.lsp_lint_and_completions.blink-cmp'),
    require('plugins.lsp_lint_and_completions.lsp'),

    require('plugins.theme.background'),
    require('plugins.theme.color_theme'),
    require('plugins.theme.snacks'),

    require('plugins.debug.dap'),
    require('plugins.debug.debug_print'),

    require('plugins.mini'),
    require('plugins.obsidian'),
    require('plugins.tabs'),
    require('plugins.sql'),
    require('plugins.previews'),
    require('plugins.file_menu'),
    -- require("plugins.none-ls"),
    -- require("plugins.surround"),
    -- require("plugins.completions"),
  },
  install = { colorscheme = { 'habamax' } },
  checker = { enabled = false },
  rocks = { enabled = false },
})

-- everything is global by default

-- local my_func = function()
--     print('Hello from Spencer')
-- end
--
-- my_func()
--
-- local my_table = {
--     here = 'there',
--     her = 'ther',
-- }
--
-- for key, val in pairs(my_table) do
--     print(key, val)
-- end

-- this vim is a global table

-- require('plugins.mydir')
-- require('plugins.mydir.another_one')
