local M = {}

M.bootstrap = function()
    require('tagusnvim.lsp.mason-lspconfig').bootstrap()
    M.lsp_status()

    local config = {
        update_in_insert = true,
        underline = true,
        severity_sort = true,
        float = {
            focusable = false,
            style = 'minimal',
            border = 'rounded',
            source = 'always',
            header = '',
            prefix = '',
            format = function(diagnostic)
                return string.format(
                    '%s (%s) [%s]',
                    diagnostic.message,
                    diagnostic.source,
                    diagnostic.code or diagnostic.user_data.lsp.code
                )
            end,
        },
        virtual_text = true,
    }

    M.setup_gutter_icons()
    M.setup_borders()

    vim.diagnostic.config(config)
end

M.lsp_status = function()
    local lsp_status = require('lsp-status')
    lsp_status.config({
        status_symbol = '',
        indicator_ok = '',
        diagnostics = false,
        current_function = true,
    })
    lsp_status.register_progress()
end

M.setup_gutter_icons = function()
    local signs =
        { Error = ' ', Warn = ' ', Hint = ' ', Info = ' ' }
    for type, icon in pairs(signs) do
        local hl = 'DiagnosticSign' .. type
        vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
    end
end

M.setup_borders = function()
    local border = {
        { '🭽', 'FloatBorder' },
        { '▔', 'FloatBorder' },
        { '🭾', 'FloatBorder' },
        { '▕', 'FloatBorder' },
        { '🭿', 'FloatBorder' },
        { '▁', 'FloatBorder' },
        { '🭼', 'FloatBorder' },
        { '▏', 'FloatBorder' },
    }

    local orig_util_open_floating_preview = vim.lsp.util.open_floating_preview
    function vim.lsp.util.open_floating_preview(contents, syntax, opts, ...)
        opts = opts or {}
        opts.border = opts.border or border
        return orig_util_open_floating_preview(contents, syntax, opts, ...)
    end
end

M.on_attach = function(client, bufnr)
    local protocol = require('vim.lsp.protocol')

    local lsp_status = require('lsp-status')
    lsp_status.on_attach(client)

    if client.server_capabilities.document_symbol then
        local navic = require('nvim-navic')
        navic.attach(client, bufnr)
    end

    require('lsp_signature').on_attach({
        floating_window = false,
        hint_enable = true,
    }, bufnr)

    local function buf_set_keymap(...)
        vim.api.nvim_buf_set_keymap(bufnr, ...)
    end

    -- Mappings.
    local opts = { noremap = true, silent = true }
    buf_set_keymap('n', 'gD', '<Cmd>lua vim.lsp.buf.declaration()<CR>', opts)
    buf_set_keymap('n', 'gd', '<Cmd>lua vim.lsp.buf.definition()<CR>', opts)
    -- formatting

    -- we use null-ls for Go formatting instead
    if client.name == 'gopls' then
        client.server_capabilities.document_formatting = false
        client.server_capabilities.document_range_formatting = false
    end

    if client.server_capabilities.document_formatting then
        vim.api.nvim_command([[augroup Format]])
        vim.api.nvim_command([[autocmd! * <buffer>]])
        vim.api.nvim_command(
            [[autocmd BufWritePre <buffer> lua vim.lsp.buf.format()]]
        )
        vim.api.nvim_command([[augroup END]])
    end

    protocol.CompletionItemKind = {
        '', -- Text
        '', -- Method
        '', -- Function
        '', -- Constructor
        '', -- Field
        '', -- Variable
        '', -- Class
        'ﰮ', -- Interface
        '', -- Module
        '', -- Property
        '', -- Unit
        '', -- Value
        '', -- Enum
        '', -- Keyword
        '﬌', -- Snippet
        '', -- Color
        '', -- File
        '', -- Reference
        '', -- Folder
        '', -- EnumMember
        '', -- Constant
        '', -- Struct
        '', -- Event
        'ﬦ', -- Operator
        '', -- TypeParameter
    }
end

M.keybindings = function()
    local keymap = vim.api.nvim_set_keymap
    local options = { noremap = true, silent = true }
    keymap('n', '<localleader>aR', '<cmd>TSLspRenameFile<CR>', options)
end

return M
