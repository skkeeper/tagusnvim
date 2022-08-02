local run_if_module_exists = require('tagusnvim.require').run_if_module_exists
local run_if_modules_exists = require('tagusnvim.require').run_if_modules_exists
local run_if_exists = require('tagusnvim.require').run_if_exists

run_if_module_exists('bufdelete', function()
    local bufdelete_cfg = require('tagusnvim.plugins.bufdelete')
    bufdelete_cfg.keybindings()
end)

run_if_module_exists('feline', function()
    local feline_cfg = require('tagusnvim.plugins.feline')
    feline_cfg.bootstrap()
end)

run_if_module_exists('indent_blankline', function()
    local indent_cfg = require('tagusnvim.plugins.indent-blankline')
    indent_cfg.bootstrap()
end)

run_if_module_exists('trouble', function()
    local trouble_cfg = require('tagusnvim.plugins.trouble')
    trouble_cfg.bootstrap()
end)

run_if_module_exists('telescope', function()
    local telescope_cfg = require('tagusnvim.plugins.telescope')
    telescope_cfg.bootstrap()
    telescope_cfg.keybindings()
end)

run_if_module_exists('neo-tree', function()
    local neotree_cfg = require('tagusnvim.plugins.neo-tree')
    neotree_cfg.bootstrap()
    neotree_cfg.keybindings()
end)

run_if_module_exists('colorizer', function()
    local colorizer_cfg = require('tagusnvim.plugins.nvim-colorizer')
    colorizer_cfg.bootstrap()
end)

run_if_module_exists('Comment', function()
    local comment_cfg = require('tagusnvim.plugins.comment')
    comment_cfg.bootstrap()
end)

run_if_module_exists('todo-comments', function()
    local todo_cfg = require('tagusnvim.plugins.todo-comments')
    todo_cfg.bootstrap()
end)

run_if_module_exists('luasnip', function()
    local luasnip_cfg = require('tagusnvim.plugins.luasnip')
    luasnip_cfg.bootstrap()
end)

run_if_module_exists('gitsigns', function()
    local gitsigns_cfg = require('tagusnvim.plugins.gitsigns')
    gitsigns_cfg.bootstrap()
    gitsigns_cfg.keybindings()
end)

run_if_exists(':DeleteHiddenBuffers', function()
    local hidden_buffers_cfg =
        require('tagusnvim.plugins.vim-delete-hidden-buffers')
    hidden_buffers_cfg.keybindings()
end)

run_if_module_exists('nvim-treesitter.configs', function()
    local treesitter_cfg = require('tagusnvim.plugins.nvim-treesitter')
    treesitter_cfg.bootstrap()
end)

run_if_module_exists('mason-lspconfig', function()
    local lsp_cfg = require('tagusnvim.lsp')
    lsp_cfg.bootstrap()
    lsp_cfg.keybindings()
end)

run_if_module_exists('null-ls', function()
    local null_ls_cfg = require('tagusnvim.lsp.null-ls')
    null_ls_cfg.bootstrap()
end)

run_if_module_exists('lspsaga', function()
    local lspsaga_cfg = require('tagusnvim.lsp.lspsaga')
    lspsaga_cfg.bootstrap()
    lspsaga_cfg.keybindings()
end)

run_if_modules_exists({ 'cmp', 'luasnip', 'nvim-autopairs' }, function()
    local cmp_cfg = require('tagusnvim.lsp.cmp')
    cmp_cfg.bootstrap()
end)

run_if_module_exists('nvim-autopairs', function()
    local autopairs_cfg = require('tagusnvim.plugins.nvim-autopairs')
    autopairs_cfg.bootstrap()
end)

run_if_module_exists('catppuccin', function()
    vim.g.catppuccin_flavour = 'frappe' -- latte, frappe, macchiato, mocha
    vim.cmd([[colorscheme catppuccin]])
end)

run_if_module_exists('gitsigns', function()
    local gitsigns_cfg = require('tagusnvim.plugins.gitsigns')
    gitsigns_cfg.bootstrap()
    gitsigns_cfg.keybindings()
end)

run_if_module_exists('scrollbar', function()
    local scrollbar_cfg = require('tagusnvim.plugins.nvim-scrollbar')
    scrollbar_cfg.bootstrap()
end)

run_if_module_exists('neotest', function()
    local neotest_cfg = require('tagusnvim.plugins.neotest')
    neotest_cfg.bootstrap()
    neotest_cfg.keybindings()
end)

run_if_module_exists('which-key', function()
    local whichkey_cfg = require('tagusnvim.plugins.which-key')
    whichkey_cfg.bootstrap()
end)

run_if_exists(':G', function()
    local fugitive_cfg = require('tagusnvim.plugins.fugitive')
    fugitive_cfg.keybindings()
end)

run_if_exists(':GV', function()
    local gv_cfg = require('tagusnvim.plugins.gv')
    gv_cfg.keybindings()
end)

run_if_module_exists('lsp_lines', function()
    require('lsp_lines').setup()
end)

require('tagusnvim.open_uri_under_cursor')

-- local is_present = require('tagusnvim.is_present')
-- if is_present('goplainrest') then
require('tagusnvim.plugins.goplainrest')
-- end
