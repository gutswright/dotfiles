-- Leaders
vim.g.mapleader = ' '
vim.g.maplocalleader = ','
vim.opt.autoread = true

-- My Base Keymaps and options
require('gwright')

-- Lazy and all plugins
require('plugins')

-- Workaround for Neovim 0.12.x treesitter crash with markdown code block injections
-- vim.treesitter.query.set('markdown', 'injections', '')
