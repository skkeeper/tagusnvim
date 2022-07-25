local M = {}

M.generate_opts = function()
    local capabilities = vim.lsp.protocol.make_client_capabilities()
    capabilities.textDocument.completion.completionItem.snippetSupport = true

    return {
        default_config = {
            cmd = { 'emmet-ls', '--stdio' },
            filetypes = { 'html', 'css', 'blade' },
            root_dir = function(fname)
                return vim.loop.cwd()
            end,
            settings = {},
        },
    }
end

return M
