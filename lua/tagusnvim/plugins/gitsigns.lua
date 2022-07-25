local M = {}

M.bootstrap = function()
    require('gitsigns').setup({
        signs = {
            add = {
                hl = 'GitSignsAdd',
                text = '+',
                numhl = 'GitSignsAddNr',
                linehl = 'GitSignsAddLn',
            },
            change = {
                hl = 'GitSignsChange',
                text = ':',
                numhl = 'GitSignsChangeNr',
                linehl = 'GitSignsChangeLn',
            },
            delete = {
                hl = 'GitSignsDelete',
                text = '_',
                numhl = 'GitSignsDeleteNr',
                linehl = 'GitSignsDeleteLn',
            },
            topdelete = {
                hl = 'GitSignsDelete',
                text = '‾',
                numhl = 'GitSignsDeleteNr',
                linehl = 'GitSignsDeleteLn',
            },
            changedelete = {
                hl = 'GitSignsChange',
                text = '~',
                numhl = 'GitSignsChangeNr',
                linehl = 'GitSignsChangeLn',
            },
        },
        signcolumn = true, -- Toggle with `:Gitsigns toggle_signs`
        numhl = false, -- Toggle with `:Gitsigns toggle_numhl`
        linehl = false, -- Toggle with `:Gitsigns toggle_linehl`
        word_diff = false, -- Toggle with `:Gitsigns toggle_word_diff`

        keymaps = {},
        watch_gitdir = {
            interval = 100,
        },
        sign_priority = 5,
        status_formatter = nil, -- Use default
    })
end

M.keybindings = function()
    local keymap = vim.api.nvim_set_keymap
    local options = { noremap = true, silent = true }
    local expr_options = { expr = true, noremap = true, silent = true }

    keymap(
        'n',
        '<localleader>hs',
        ':lua require"gitsigns".stage_hunk()<CR>',
        options
    )
    keymap(
        'n',
        '<localleader>hu',
        ':lua require"gitsigns".undo_stage_hunk()<CR>',
        options
    )
    keymap(
        'n',
        '<localleader>hr',
        ':lua require"gitsigns".reset_hunk()<CR>',
        options
    )
    keymap(
        'n',
        '<localleader>hv',
        ':lua require"gitsigns".preview_hunk()<CR>',
        options
    )
    keymap(
        'n',
        '<localleader>hb',
        ':lua require"gitsigns".blame_line()<CR>',
        options
    )
    keymap(
        'n',
        '<localleader>hR',
        ':lua require"gitsigns".reset_buffer()<CR>',
        options
    )
    keymap(
        'n',
        '<localleader>hS',
        ':lua require"gitsigns".stage_buffer()<CR>',
        options
    )
    keymap(
        'n',
        '<localleader>hU',
        ':lua require"gitsigns".reset_buffer_index()<CR>',
        options
    )

    keymap(
        'n',
        ']c',
        "&diff ? ']c' : ':lua require\"gitsigns.actions\".next_hunk()<CR>'",
        expr_options
    )
    keymap(
        'n',
        '[c',
        "&diff ? '[c' : ':lua require\"gitsigns.actions\".prev_hunk()<CR>'",
        expr_options
    )

    keymap(
        'v',
        '<localleader>hs',
        ':lua require"gitsigns".stage_hunk({vim.fn.line("."), vim.fn.line("v")})<CR>',
        options
    )
    keymap(
        'v',
        '<localleader>hr',
        ':lua require"gitsigns".reset_hunk({vim.fn.line("."), vim.fn.line("v")})<CR>',
        options
    )

    keymap(
        'o',
        'ih',
        ':<C-U>lua require"gitsigns.actions".select_hunk()<CR>',
        options
    )
    keymap(
        'x',
        'ih',
        ':<C-U>lua require"gitsigns.actions".select_hunk()<CR>',
        options
    )
end

return M
