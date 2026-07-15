-- In case anything every breaks, this file will still run (if something in the plugins dir breaks nvim will be O.K.)

vim.o.clipboard = 'unnamedplus'
vim.opt.clipboard = 'unnamedplus'
vim.keymap.set('i', 'jk', '<esc>')
vim.keymap.set('i', 'JK', '<esc>')

vim.wo.number = true
vim.opt.rnu = true

vim.opt.mouse = 'a'
vim.opt.mousemodel = 'popup_setpos'

vim.opt.swapfile = false

vim.opt.smartcase = true -- makes searching easier
vim.opt.ignorecase = true

vim.opt.smartindent = true

vim.opt.spelllang = 'en_us'
vim.opt.spell = true

vim.hlsearch = false
vim.incsearch = true

vim.opt.tabstop = 2
vim.opt.softtabstop = 2
vim.opt.shiftwidth = 2
vim.opt.expandtab = true
vim.opt.autoindent = true

vim.keymap.set('n', '<leader>uw', function()
  vim.wo.wrap = not vim.wo.wrap
end, { desc = 'Toggle line wrap ' })

-- vim.keymap.set('n', 'y', 'h', { noremap = true })
-- vim.keymap.set('n', 'h', 'j', { noremap = true })
-- vim.keymap.set('n', 'a', 'k', { noremap = true })
-- vim.keymap.set('n', 'e', 'l', { noremap = true })
--
-- vim.keymap.set('n', 'j', 'a', { noremap = true })
-- vim.keymap.set('n', 'J', 'A', { noremap = true })
-- vim.keymap.set('n', '_', "'", { noremap = true })
-- vim.keymap.set('n', "'", 'y', { noremap = true })
-- vim.keymap.set('n', "''", 'yy', { noremap = true })
-- vim.keymap.set('n', 'k', 'J', { noremap = true })
-- vim.keymap.set('n', '-', ',', { noremap = true })
-- vim.keymap.set('n', 'l', 'e', { noremap = true })
--
-- vim.keymap.set('v', 'y', 'h', { noremap = true })
-- vim.keymap.set('v', 'h', 'j', { noremap = true })
-- -- vim.keymap.set('v', 'a', 'k', { noremap = true })
-- vim.keymap.set('v', 'o', 'k', { noremap = true })
-- vim.keymap.set('v', 'e', 'l', { noremap = true })
-- vim.keymap.set('v', '_', "'", { noremap = true })
--
-- vim.keymap.set('v', "'", 'y', { noremap = true })
-- vim.keymap.set('v', '-', ',', { noremap = true })
-- vim.keymap.set('v', 'l', 'e', { noremap = true })
--
-- vim.keymap.set('x', 'j', 'a', { noremap = true })
-- vim.keymap.set('x', 'J', 'A', { noremap = true })
-- vim.keymap.set('x', '_', "'", { noremap = true })
-- vim.keymap.set('x', "'", 'y', { noremap = true })
--
-- vim.keymap.set('x', 'k', 'J', { noremap = true })
-- vim.keymap.set('x', '-', ',', { noremap = true })
-- vim.keymap.set('x', 'l', 'e', { noremap = true })
--
-- vim.keymap.set('x', 'y', 'h', { noremap = true })
-- vim.keymap.set('x', 'h', 'j', { noremap = true })
-- vim.keymap.set('x', 'a', 'k', { noremap = true })
-- vim.keymap.set('x', 'e', 'l', { noremap = true })
--
-- vim.keymap.set('n', '<C-w>y', '<C-w>h', { noremap = true })
-- vim.keymap.set('n', '<C-w>h', '<C-w>j', { noremap = true })
-- vim.keymap.set('n', '<C-w>a', '<C-w>k', { noremap = true })
-- vim.keymap.set('n', '<C-w>e', '<C-w>l', { noremap = true })
--
-- vim.keymap.set('n', '<A-a>', ':m .-2<CR>==', { desc = 'Move line up' })
-- vim.keymap.set('n', '<A-h>', ':m .+1<CR>==', { desc = 'Move line down' })
-- vim.keymap.set('i', '<A-a>', '<Esc>:m .-2<CR>==gi', { desc = 'Move line up' })
-- vim.keymap.set('i', '<A-h>', '<Esc>:m .+1<CR>==gi', { desc = 'Move line down' })

-- vim.cmd([[
--   amenu 10.10 PopUp.Nvim\ Tree :NvimTreeToggle<CR>
--   amenu 10.15 PopUp.-Sep- :
-- ]])

-- Use pcall to "try" deleting the menu without crashing if it fails
-- pcall(vim.cmd, 'aunmenu Popup')
--
-- -- Create your new menu item
--
-- vim.cmd([[
--   aunmenu PopUp
--   anoremenu PopUp.Inspect <cmd>Inspect<CR>
-- ]])

-- vim.g.did_install_default_menus = 1

vim.api.nvim_clear_autocmds({ event = 'MenuPopup', group = 'nvim.popupmenu' })

vim.api.nvim_create_autocmd('MenuPopup', {
  callback = function()
    -- Clear whatever's there first
    pcall(vim.cmd, 'aunmenu PopUp')

    vim.cmd('amenu PopUp.Nvim\\ Tree :NvimTreeToggle<CR>')
    -- PopUp.vim.cmd('amenu PopUp.-sep-       <Nop>') -- separator

    vim.cmd('amenu PopUp.Show\\ Definition :lua vim.lsp.buf.hover()<CR>')
  end,
})

-- Set fillchars to use thicker characters
vim.opt.fillchars = {
  horiz = '▀',
  horizup = '▀',
  horizdown = '▄',
  vert = '█',
  -- '█'▌
  vertleft = '█',
  vertright = '█',
  verthoriz = '█',
}
