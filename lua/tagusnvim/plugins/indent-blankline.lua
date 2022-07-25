local M = {}

M.bootstrap = function()
    vim.opt.list = true
    vim.opt.listchars:append('eol:↴')

    require('indent_blankline').setup({
        show_current_context = false,
        show_current_context_start = false,
        show_end_of_line = true,
        space_char_blankline = ' ',

        char = '',
        char_highlight_list = {
            'Normal',
            'NormalFloat',
        },
        space_char_highlight_list = {
            'Normal',
            'NormalFloat',
        },
        show_trailing_blankline_indent = false,
    })
end

return M
