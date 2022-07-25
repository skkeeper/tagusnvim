local lsp_installer = require('nvim-lsp-installer')

local required_servers = {
    'sumneko_lua',
    'tsserver',
    'eslint',
    'cssls',
    'jsonls',
    'html',
    'emmet_ls',
    'vimls',
    'yamlls',
}

lsp_installer.setup({
    ensure_installed = required_servers
})

for _, server in ipairs(required_servers) do
    local capabilities = require('cmp_nvim_lsp').update_capabilities(
        vim.lsp.protocol.make_client_capabilities()
    )
    local on_attach = require('tagusnvim/lsp').on_attach

    local opts = {
        capabilities = capabilities,
        on_attach = on_attach,
    }

    if server == 'tsserver' then
        require("typescript").setup({
            disable_commands = false, -- prevent the plugin from creating Vim commands
            disable_formatting = false, -- disable tsserver's formatting capabilities
            debug = false, -- enable debug logging for commands
            server = opts,
        })
        goto continue
    elseif server == 'emmet_ls' then
        local extra_opts = require('tagusnvim/lsp/emmet-ls').generate_opts()
        opts = vim.tbl_deep_extend('force', opts, extra_opts)
    elseif server == 'jsonls' then
        local extra_opts = require('tagusnvim/lsp/jsonls').generate_opts()
        opts = vim.tbl_deep_extend('force', opts, extra_opts)
    end

    require('lspconfig')[server].setup(opts)

    ::continue::
end
