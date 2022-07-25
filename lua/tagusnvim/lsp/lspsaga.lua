local M = {}

M.bootstrap = function()
    local saga = require('lspsaga')
    local lsp = vim.lsp
    local handlers = lsp.handlers
    saga.init_lsp_saga({
        border_style = 'round',
        finder_action_keys = {
            open = '<CR>',
            vsplit = 's',
            split = 'i',
            quit = 'q',
            scroll_down = '<C-f>',
            scroll_up = '<C-b>', -- quit can be a table
        },
    })

    local pop_opts = { border = 'rounded', max_width = 80 }
    handlers['textDocument/hover'] = lsp.with(handlers.hover, pop_opts)
    handlers['textDocument/signatureHelp'] = lsp.with(
        handlers.signature_help,
        pop_opts
    )
end

M.keybindings = function()
    local keymap = vim.api.nvim_set_keymap
    local options = { noremap = true, silent = true }
    keymap('n', 'K', ':lua vim.lsp.buf.hover()<CR>', options)
    keymap('n', '<C-k>', ':lua vim.lsp.buf.signature_help()<CR>', options)
    keymap('n', 'gh', '<Cmd>Lspsaga lsp_finder<CR>', options)
    keymap('n', 'gj', '<Cmd>Lspsaga diagnostic_jump_next<cr>', options)
    keymap('n', 'gk', '<Cmd>Lspsaga diagnostic_jump_prev<cr>', options)

    keymap(
        'n',
        '<localleader>ac',
        "<cmd>lua require('lspsaga.codeaction').code_action()<CR>",
        options
    )
    keymap(
        'v',
        '<localleader>ac',
        ":<C-U>lua require('lspsaga.codeaction').range_code_action()<CR>",
        options
    )
    keymap(
        'n',
        '<f2>',
        "<cmd>lua require('lspsaga.rename').rename()<CR>",
        options
    )
    keymap(
        'n',
        '<localleader>ap',
        "<cmd>lua require'lspsaga.provider'.preview_definition()<CR>",
        options
    )
    keymap(
        'n',
        '<localleader>ag',
        "<cmd>lua require'lspsaga.diagnostic'.show_cursor_diagnostics()<CR>",
        options
    )
end

return M
