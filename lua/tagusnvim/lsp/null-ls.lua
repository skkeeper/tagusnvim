local M = {}

M.bootstrap = function()
    local null_ls = require('null-ls')
    local formatting = null_ls.builtins.formatting
    local diagnostics = null_ls.builtins.diagnostics
    local code_actions = null_ls.builtins.code_actions
    local on_attach = require('tagusnvim.lsp').on_attach

    local custom_options = {
        diagnostics_format = '[#{c}] #{m} (#{s})',
    }

    null_ls.setup({
        on_attach = on_attach,
        sources = {
            code_actions.gitrebase,
            code_actions.gitsigns,
            code_actions.proselint,
            code_actions.shellcheck,
            diagnostics.alex.with(custom_options),
            diagnostics.gitlint.with(custom_options),
            diagnostics.golangci_lint.with(custom_options),
            diagnostics.jsonlint.with(custom_options),
            diagnostics.markdownlint.with(custom_options),
            diagnostics.proselint.with(custom_options),
            diagnostics.revive.with(custom_options),
            diagnostics.shellcheck.with(custom_options),
            diagnostics.stylelint.with(custom_options),
            diagnostics.write_good.with(custom_options),
            formatting.gofmt,
            formatting.goimports,
            formatting.markdownlint,
            formatting.prettier,
            formatting.stylelint,
            formatting.stylua,
        },
    })
end
return M
