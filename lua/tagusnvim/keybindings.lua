local keymap = vim.api.nvim_set_keymap
local options = { noremap = true, silent = true }

local g = vim.g
local o = vim.o

g.mapleader = '\\'
g.maplocalleader = ' '

o.langmap = 'ç[,º]'

keymap('n', ',e', ':e **/*<C-z><S-Tab>', options)
keymap('n', ',f', ':find **/*<C-z><S-Tab>', options)

-- netrw
keymap('n', '<leader>e', ':Explore<CR>', options)
keymap('n', '<leader>pe', ':Explore .<CR>', options)

-- move lines
keymap('n', '<A-j>', ':m .+1<CR>==', options)
keymap('n', '<A-k>', ':m .-2<CR>==', options)
keymap('i', '<A-j>', '<Esc>:m .+1<CR>==gi', options)
keymap('i', '<A-k>', '<Esc>:m .-2<CR>==gi', options)
keymap('v', '<A-j>', ":m '>+1<CR>gv=gv", options)
keymap('v', '<A-k>', ":m '<-2<CR>gv=gv", options)

-- Resize with arrows
keymap('n', '<C-W><up>', '<cmd>resize -2<CR>', options)
keymap('n', '<C-W><down>', '<cmd>resize +2<CR>', options)
keymap('n', '<C-W><left>', '<cmd>vertical resize -2<CR>', options)
keymap('n', '<C-W><right>', '<cmd>vertical resize +2<CR>', options)

-- Align blocks of text and keep them selected
keymap('v', '<', '<gv', options)
keymap('v', '>', '>gv', options)

-- buffers
keymap('n', '<leader>j', ':bnext<CR>', options)
keymap('n', '<leader>k', ':bprevious<CR>', options)

-- quickfix
keymap('n', '<leader>co', ':copen<CR>', options)
keymap('n', '<leader>cf', ':cfirst<CR>', options)
keymap('n', '<leader>cl', ':clast<CR>', options)
keymap('n', '<leader>cn', ':cnext<CR>', options)
keymap('n', '<leader>cp', ':cprevious<CR>', options)
keymap('n', '<leader>cc', ':cclose<CR>', options)

-- location list
keymap('n', '<localleader>co', ':lopen<CR>', options)
keymap('n', '<localleader>cf', ':lfirst<CR>', options)
keymap('n', '<localleader>cl', ':llast<CR>', options)
keymap('n', '<localleader>cn', ':lnext<CR>', options)
keymap('n', '<localleader>cp', ':lprevious<CR>', options)
keymap('n', '<localleader>cc', ':lclose<CR>', options)

-- obsidian notes
keymap('n', '<leader>ww', ':e $HOME/notes/Morphotech/Journal.md<CR>', options)
