local M = {}

M.keybindings = function()
    local keymap = vim.api.nvim_set_keymap
    local options = { noremap = true, silent = true }
    keymap(
        'n',
        '<localleader>tn',
        '<Cmd>lua require("neotest").run.run()<CR>',
        options
    )
    keymap(
        'n',
        '<localleader>ts',
        '<Cmd>lua require("neotest").summary.toggle()<CR>',
        options
    )
    keymap(
        'n',
        '<localleader>to',
        '<Cmd>lua require("neotest").output.open({ enter = true })<CR>',
        options
    )
    keymap(
        'n',
        '<localleader>tf',
        '<Cmd>lua require("neotest").run.run(vim.fn.expand("%"))<CR>',
        options
    )
end

M.bootstrap = function()
    require('neotest').setup({
        adapters = {
            require('neotest-plenary'),
            -- require('neotest-jest'),
            require('neotest-vim-test')({
                ignore_file_types = { 'python', 'vim', 'lua' },
            }),
        },
    })
end

return M
