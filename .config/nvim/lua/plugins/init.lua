local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
	local lazyrepo = "https://github.com/folke/lazy.nvim.git"
	local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
	if vim.v.shell_error ~= 0 then
		vim.api.nvim_echo({
			{ "Failed to clone lazy.nvim:\n", "ErrorMsg" },
			{ out, "WarningMsg" },
			{ "\nPress any key to exit..." },
		}, true, {})
		vim.fn.getchar()
		os.exit(1)
	end
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
	spec = {
		require("plugins.dap"),
		require("plugins.background"),
		require("plugins.mini"),
		require("plugins.tabs"),
		require("plugins.theme"),
		require("plugins.sql"),
		require("plugins.treesitter"),
		require("plugins.lsp"),
		require("plugins.none-ls"),
    require("plugins.snacks"),
    -- require("plugins.completions"),
    require("plugins.blink-cmp"),
	},
	install = { colorscheme = { "habamax" } },
	checker = { enabled = false},
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
