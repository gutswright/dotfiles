-- In case anything every breaks, this file will still run (if something in the plugins dir breaks nvim will be O.K.)

vim.o.clipboard = 'unnamedplus' -- sync clipboards

vim.wo.number = true
vim.opt.rnu = true

vim.o.mouse = 'a'

vim.opt.smartcase = true -- makes searching easier
vim.opt.ignorecase = true

vim.opt.smartindent = true

vim.opt.spelllang = 'en_us'
vim.opt.spell = true

vim.hlsearch = false
vim.incsearch = true

vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true
vim.opt.autoindent = true
