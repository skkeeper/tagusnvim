local M = {}

M.bootstrap = function()
    local saga = require('lspsaga')
    local lsp = vim.lsp
    local handlers = lsp.handlers
    saga.init_lsp_saga({
        border_style = 'single',
        finder_action_keys = {
            open = '<CR>',
            vsplit = 's',
            split = 'i',
            quit = 'q',
            scroll_down = '<C-f>',
            scroll_up = '<C-b>', -- quit can be a table
        },
        code_action_lightbulb = {
            enable = true,
            enable_in_insert = true,
            cache_code_action = true,
            sign = true,
            update_time = 150,
            sign_priority = 20,
            virtual_text = false,
        },
    })

    local pop_opts = { border = 'single', max_width = 80 }
    handlers['textDocument/hover'] = lsp.with(handlers.hover, pop_opts)
    handlers['textDocument/signatureHelp'] =
        lsp.with(handlers.signature_help, pop_opts)
end

M.keybindings = function()
    local keymap = vim.keymap.set
    local options = { noremap = true, silent = true }
    keymap('n', 'K', '<Cmd>Lspsaga hover_doc<CR>', options)
    keymap('n', '<C-k>', ':lua vim.lsp.buf.signature_help()<CR>', options)
    keymap('n', 'gh', '<Cmd>Lspsaga lsp_finder<CR>', options)
    keymap('n', 'gj', '<Cmd>Lspsaga diagnostic_jump_next<cr>', options)
    keymap('n', 'gk', '<Cmd>Lspsaga diagnostic_jump_prev<cr>', options)

    keymap('n', '<localleader>ac', '<Cmd>Lspsaga code_action<CR>', options)
    keymap('v', '<localleader>ac', '<Cmd>Lspsaga code_action<CR>', options)
    keymap('n', '<f2>', '<Cmd>Lspsaga rename<CR>', options)
    keymap('n', '<localleader>ap', '<Cmd>Lspsaga peek_definition<CR>', options)
    keymap(
        'n',
        '<localleader>ag',
        '<Cmd>Lspsaga show_line_diagnostics<CR>',
        options
    )
    keymap('n', '<localleader>o', '<Cmd>LSoutlineToggle<CR>', options)
end

return M
