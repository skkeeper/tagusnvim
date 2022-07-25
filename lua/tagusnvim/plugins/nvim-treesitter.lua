local M = {}

M.bootstrap = function()
    local wo = vim.wo
    require('nvim-treesitter.configs').setup({
        highlight = {
            enable = true,
            additional_vim_regex_highlighting = false,
        },
        indent = { enable = true },
        ensure_installed = {
            'bash',
            'bibtex',
            'c',
            'c_sharp',
            'cmake',
            'cpp',
            'css',
            'dart',
            'dockerfile',
            'fish',
            'go',
            'gomod',
            'gowork',
            'graphql',
            'hjson',
            'html',
            'http',
            'java',
            'javascript',
            'jsdoc',
            'json',
            'json5',
            'jsonc',
            'kotlin',
            'latex',
            'ledger',
            'llvm',
            'lua',
            'make',
            'ninja',
            'perl',
            'php',
            'python',
            'regex',
            'ruby',
            'rust',
            'scss',
            'toml',
            'tsx',
            'typescript',
            'yaml',
        },
        context_commentstring = { enable = true, enable_autocmd = false },
        autopairs = { enable = true },
        rainbow = {
            enable = true,
            disable = { 'html' },
            extended_mode = false,
            max_file_lines = nil,
        },
        autotag = { enable = true },
        incremental_selection = {
            enable = true,
            keymaps = {
                init_selection = 'gnn',
                scope_incremental = 'grn',
                node_incremental = 'grc',
                node_decremental = 'grm',
            },
        },
        textobjects = {
            select = {
                enable = true,
                lookahead = true, -- Automatically jump forward to textobj, similar to targets.vim
                keymaps = {
                    -- You can use the capture groups defined in textobjects.scm
                    ['af'] = '@function.outer',
                    ['if'] = '@function.inner',
                    ['ac'] = '@class.outer',
                    ['ic'] = '@class.inner',
                },
            },
            move = {
                enable = true,
                set_jumps = true, -- whether to set jumps in the jumplist
                goto_next_start = {
                    [']m'] = '@function.outer',
                    [']]'] = '@class.outer',
                },
                goto_next_end = {
                    [']M'] = '@function.outer',
                    [']['] = '@class.outer',
                },
                goto_previous_start = {
                    ['[m'] = '@function.outer',
                    ['[['] = '@class.outer',
                },
                goto_previous_end = {
                    ['[M'] = '@function.outer',
                    ['[]'] = '@class.outer',
                },
            },
        },
    })
    local parser_config =
        require('nvim-treesitter.parsers').get_parser_configs()
    parser_config.tsx.filetype_to_parsername = {
        'javascript',
        'typescript.tsx',
        'javascriptreact',
    }

    wo.foldmethod = 'expr'
    wo.foldexpr = 'nvim_treesitter#foldexpr()'
end

return M
