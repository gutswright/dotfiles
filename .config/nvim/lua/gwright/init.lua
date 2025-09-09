-- In case anything every breaks, this file will still run (if something in the plugins dir breaks nvim will be O.K.)

vim.o.clipboard = 'unnamedplus' -- sync clipboards
vim.opt.clipboard = 'unnamedplus'
vim.keymap.set('i', 'jk', '<esc>')
vim.keymap.set('i', 'JK', '<esc>')

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

vim.opt.tabstop = 2
vim.opt.softtabstop = 2
vim.opt.shiftwidth = 2
vim.opt.expandtab = true
vim.opt.autoindent = true
--
-- I need a new home for y, Y
-- a, A,
-- e, E
--
-- b = back one word
-- B = back but slightly differnent
-- l = right one char
-- L = Go to line #
-- d = delete char
-- D = delete to end of line
-- w = moves forward by word
-- W = moves forward by WORD
-- z = centering line, folds?
-- Z = ZZ is :wq ZQ is :q!
-- - = moves to first non blank char on previous line
-- " = "specify a register can do a lot with this
-- f = find character forward
-- F = find character backward
-- o = open newline below
-- O = open newline above
-- u = undo last change
-- U = undo all changes on current line
-- j = down (line)
-- J = join lines this is useful
-- ; = repeats the last find (works for f, F, t, T)
-- : = go into command mode
-- n = next match
-- N = prior match
-- r = replace character
-- R = Replace mode
-- t = to right before char on line
-- T = to right after char on line
-- s = sub a char
-- S = sub out a whole line
-- g = go to (gg, gf, gd, gU, gu)
-- G = Go to end of file, 34G
-- y = yank
-- Y = shortcut for yy
-- h = lef'
-- H = nothing
-- a = insert after char
-- A = insert at end of line
-- e = end of word
-- E = end of WORD
-- i = insert before char
-- I = insete at beginning of line
-- , = repeats f, F, t, or T in reverse
-- ? = search going backwards
-- q = record macro
-- Q = enter Ex mode - useless
-- x = delete char
-- X = delete char before cursor
-- m = mark []
-- M = nada
-- c = change
-- C = short for d$i
-- v = visual mode move by char
-- V = visual line move by line
-- k = move cursor up
-- K = lookup word un'er cursor
-- p = paste after char or line
-- P = past before char or line
-- > = indent
-- - = go to start of line (previous)
-- _ = go to start of line (with a char)
-- / = search for
-- < = unindent

vim.keymap.set('n', 'y', 'h', { noremap = true })
vim.keymap.set('n', 'h', 'j', { noremap = true })
vim.keymap.set('n', 'a', 'k', { noremap = true })
vim.keymap.set('n', 'e', 'l', { noremap = true })

vim.keymap.set('n', 'j', 'a', { noremap = true })
vim.keymap.set('n', 'J', 'A', { noremap = true })
vim.keymap.set('n', '_', "'", { noremap = true })
vim.keymap.set('n', "'", 'y', { noremap = true })
vim.keymap.set('n', "''", 'yy', { noremap = true })
vim.keymap.set('n', 'k', 'J', { noremap = true })
vim.keymap.set('n', '-', ',', { noremap = true })
vim.keymap.set('n', 'l', 'e', { noremap = true })

vim.keymap.set('v', 'y', 'h', { noremap = true })
vim.keymap.set('v', 'h', 'j', { noremap = true })
vim.keymap.set('v', 'a', 'k', { noremap = true }) -- Keep this for up movement
vim.keymap.set('v', 'e', 'l', { noremap = true })
vim.keymap.set('v', '_', "'", { noremap = true })
-- vim.keymap.set('v', 'va', 'vj', { noremap = true })  -- Use 'va' instead of 'a'
-- vim.keymap.set('v', 'vaa', 'vjj', { noremap = true })
vim.keymap.set('v', "'", 'y', { noremap = true })
vim.keymap.set('v', '-', ',', { noremap = true })
vim.keymap.set('v', 'l', 'e', { noremap = true })

-- Visual Block mode specific mappings for insertion/editing
-- Basic insert operations
vim.keymap.set('x', 'I', 'I', { noremap = true, desc = 'Insert at beginning of block' })
vim.keymap.set('x', 'A', 'A', { noremap = true, desc = 'Insert at end of block' })

-- Use remapped keys for insert operations in visual block
vim.keymap.set('x', 'j', 'I', { noremap = true, desc = 'Insert at beginning of block (remapped)' })
vim.keymap.set('x', 'J', 'A', { noremap = true, desc = 'Insert at end of block (remapped)' })

-- Change operations in visual block
vim.keymap.set('x', 'c', 'c', { noremap = true, desc = 'Change selected block' })
vim.keymap.set('x', 'C', 'C', { noremap = true, desc = 'Change to end of lines in block' })

-- Delete and insert in visual block
vim.keymap.set('x', 's', 'c', { noremap = true, desc = 'Substitute selected block' })
vim.keymap.set('x', 'S', 'S', { noremap = true, desc = 'Substitute lines in block' })

-- Replace character in visual block
vim.keymap.set('x', 'r', 'r', { noremap = true, desc = 'Replace characters in block' })

-- Additional useful visual block operations
vim.keymap.set('x', 'o', 'o', { noremap = true, desc = 'Go to other end of block' })
vim.keymap.set('x', 'O', 'O', { noremap = true, desc = 'Go to other corner of block' })

-- Movement mappings for visual block (inherit from visual mode)
vim.keymap.set('x', 'y', 'h', { noremap = true })
vim.keymap.set('x', 'h', 'j', { noremap = true })
vim.keymap.set('x', 'a', 'k', { noremap = true })
vim.keymap.set('x', 'e', 'l', { noremap = true })
vim.keymap.set('x', '_', "'", { noremap = true })
vim.keymap.set('x', "'", 'y', { noremap = true })
vim.keymap.set('x', '-', ',', { noremap = true })
vim.keymap.set('x', 'l', 'e', { noremap = true })
vim.filetype.add({
    extension = {
        m = 'matlab',
        oct = 'matlab', -- This is the important line for .oct files
    },
})
vim.g.filetype_m = 'matlab'

-- In your init.lua or early-loading config file
vim.filetype.add({
    extension = {
        m = 'matlab',
    },
    pattern = {
        ['.*%.m'] = 'matlab',
    },
})

-- Fix TreeSitter highlighting after formatting
vim.api.nvim_create_autocmd('BufWritePost', {
    pattern = '*.py',
    callback = function()
        -- Re-enable TreeSitter highlighting for Python files after save
        vim.schedule(function()
            local bufnr = vim.api.nvim_get_current_buf()
            if vim.bo[bufnr].filetype == 'python' then
                -- Force TreeSitter to re-enable highlighting
                vim.cmd('TSEnable highlight python')
            end
        end)
    end,
})
