local opt = vim.opt

local wo = vim.wo
local cmd = vim.cmd

opt.cindent = true
opt.colorcolumn = '80'
opt.clipboard = 'unnamedplus'
opt.expandtab = true
opt.exrc = true
opt.foldmethod = 'syntax'
opt.foldcolumn = '1'
opt.foldlevelstart = 20
opt.ignorecase = true
opt.incsearch = true
opt.inccommand = 'split'
opt.mouse = 'a'
opt.completeopt = 'menuone,noselect'
wo.wrap = false
opt.number = true
opt.path = { '.' }
opt.signcolumn = 'yes'
opt.shiftwidth = 2
opt.smartcase = true
opt.smarttab = true
opt.spell = false
-- opt.spellfile="spell/pt-preao.utf-8.add"
opt.spelllang = 'en_us'
opt.scrolloff = 8
opt.relativenumber = true
opt.tabstop = 2
opt.wildignore = {
    'node_modules/**',
    '.git/**',
    '.settings/**',
    '.mvn/**',
    '*.pyc',
}
opt.wildcharm = vim.fn.char2nr('<C-z>')
opt.list = true
opt.listchars = 'eol:↩,tab:  '

opt.title = true
opt.showmode = false

vim.o.updatetime = 250
vim.o.ch = 0

opt.syntax = 'enable'
if vim.fn.has('termguicolors') == 1 then
    opt.termguicolors = true
end

vim.api.nvim_command([[
    autocmd ColorScheme * highlight Normal guibg=NONE ctermbg=NONE
    autocmd ColorScheme * highlight EndOfBuffer guibg=NONE ctermbg=NONE
]])
