local M = {}

M.bootstrap = function()
    require('mason').setup()
    local required_servers = {
        'sumneko_lua',
        'cssls',
        'jsonls',
        'html',
        'emmet_ls',
        'vimls',
        'yamlls',
        -- 'quick_lint_js',
    }
    local mason_lspconfig = require('mason-lspconfig')

    local is_present = require('tagusnvim.is_present')
    if is_present('node --version') then
        table.insert(required_servers, 'eslint')
        table.insert(required_servers, 'tsserver')
    end

    mason_lspconfig.setup({
        ensure_installed = required_servers,
    })

    local installed_servers = mason_lspconfig.get_installed_servers()
    for k, server in ipairs(installed_servers) do
        local capabilities = require('cmp_nvim_lsp').update_capabilities(
            vim.lsp.protocol.make_client_capabilities()
        )
        local on_attach = require('tagusnvim/lsp').on_attach

        local opts = {
            capabilities = capabilities,
            on_attach = on_attach,
        }

        if server == 'tsserver' then
            require('typescript').setup({
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
        elseif server == 'quick_lint_js' then
            require('lspconfig').quick_lint_js.setup({})
            goto continue
        end

        require('lspconfig')[server].setup(opts)

        ::continue::
    end

    M.tool_installer()
end

M.tool_installer = function()
    local ensure_installed = {
        'bash-language-server',
        'lua-language-server',
        'vim-language-server',
        'shellcheck',
        'editorconfig-checker',
        'luacheck',
        'shellcheck',
        'goimports',
        'write-good',
        'alex',
        'markdownlint',
    }

    local is_present = require('tagusnvim.is_present')
    if is_present('go version') then
        table.insert(ensure_installed, 'golangci-lint')
        table.insert(ensure_installed, 'gopls')
        table.insert(ensure_installed, 'revive')
    end
    if is_present('cargo version') then
        table.insert(ensure_installed, 'stylua')
    end

    require('mason-tool-installer').setup({
        ensure_installed = ensure_installed,
    })
end

return M
