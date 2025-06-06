-- :bn == buffer next
-- Bootstrap lazy.nvim
-- THIS JUST INSTALLS LAZY
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
-- THIS JUST INSTALLS LAZY

-- Setup lazy.nvim
require('lazy').setup({
    spec = {
        require('plugins.code'),
        require('plugins.format'),
        require('plugins.lsp'),
        require('plugins.dap'),
        require('plugins.background'),
        require('plugins.mini'),
        require('plugins.markdown_preview'),
        require('plugins.snacks'),
        require('plugins.tabs'),
        require('plugins.avanteai'),
        require('plugins.theme'),
        require('plugins.format'),
        require('plugins.flutter_tools'),
        -- add your plugins here
    },
    -- Configure any other settings here. See the documentation for more details.
    -- colorscheme that will be used when installing plugins.
    install = { colorscheme = { 'habamax' } },
    -- automatically check for plugin updates
    checker = { enabled = true },
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
