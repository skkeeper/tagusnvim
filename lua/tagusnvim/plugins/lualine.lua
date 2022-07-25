local M = {}

M.bootstrap = function()
    require('lualine').setup({
        sections = {
            lualine_c = {
                'filename',
                function()
                    return require('lsp-status').status()
                end,
            },
            lualine_x = {
                'encoding',
                'fileformat',
                { 'filetype', colored = true, icon_only = true },
            },
        },
        extensions = { 'quickfix', 'fugitive' },
    })
end

return M
