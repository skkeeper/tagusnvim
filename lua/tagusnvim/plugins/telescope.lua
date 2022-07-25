local M = {}

M.bootstrap = function()
    local actions = require('telescope.actions')
    local telescope = require('telescope')
    telescope.load_extension('fzf')
    local trouble = require('trouble.providers.telescope')
    telescope.setup({
        defaults = {
            file_sorter = require('telescope.sorters').get_fzy_sorter,
            prompt_prefix = ' >',
            color_devicons = true,

            file_previewer = require('telescope.previewers').vim_buffer_cat.new,
            grep_previewer = require('telescope.previewers').vim_buffer_vimgrep.new,
            qflist_previewer = require('telescope.previewers').vim_buffer_qflist.new,

            borderchars = {
                '─',
                '│',
                '─',
                '│',
                '╭',
                '╮',
                '╯',
                '╰',
            },

            mappings = {
                i = {
                    ['<C-x>'] = false,
                    ['<C-q>'] = actions.send_to_qflist,
                    --          ['<C-t>'] = trouble.open_with_trouble,
                },
                n = { ['<C-t>'] = trouble.open_with_trouble },
            },
        },
        extensions = {
            fzy_native = {
                override_generic_sorter = false,
                override_file_sorter = true,
            },
        },
    })
end

M.search_dotfiles = function()
    require('telescope.builtin').find_files({
        prompt_title = '< VimRC >',
        cwd = '$HOME/.config/nvim/',
    })
end

M.search_notes = function()
    require('telescope.builtin').find_files({
        prompt_title = '< Obsidian >',
        cwd = '$HOME/.notes',
    })
end

M.keybindings = function()
    local keymap = vim.api.nvim_set_keymap
    local options = { noremap = true, silent = true }
    keymap('n', '<C-p>', [[<Cmd> Telescope git_files<CR>]], options)
    keymap(
        'n',
        '<leader>ps',
        [[<Cmd>lua require("telescope").extensions.live_grep_args.live_grep_args()<CR>]],
        options
    )
    keymap('n', ',p', [[<Cmd> Telescope find_files<CR>]], options)
    keymap('n', ',f', [[<Cmd> Telescope file_browser<CR>]], options)
    keymap('n', ',b', [[<Cmd> Telescope buffers<CR>]], options)
    keymap('n', ',t', [[<Cmd> Telescope tags<CR>]], options)
    keymap('n', ',q', [[<Cmd> Telescope quickfix<CR>]], options)
    keymap('n', ',c', [[<Cmd> Telescope command_history<CR>]], options)

    keymap('n', '<leader>pc', [[<Cmd> Telescope git_commits<CR>]], options)
    keymap('n', '<leader>pf', [[<Cmd> Telescope git_bcommits<CR>]], options)
    keymap('n', '<leader>pb', [[<Cmd> Telescope git_branches<CR>]], options)
    keymap('n', '<leader>ph', [[<Cmd> Telescope git_status<CR>]], options)

    keymap(
        'n',
        '<localleader>ar',
        [[<Cmd> Telescope lsp_references<CR>]],
        options
    )
    keymap(
        'n',
        '<localleader>aC',
        [[<Cmd> Telescope lsp_code_actions<CR>]],
        options
    )
    keymap(
        'n',
        '<localleader>ai',
        [[<Cmd> Telescope lsp_implementations<CR>]],
        options
    )
    keymap(
        'n',
        '<localleader>at',
        [[<Cmd> Telescope lsp_type_definitions<CR>]],
        options
    )
    keymap(
        'n',
        '<localleader>ad',
        [[<Cmd> Telescope lsp_definitions<CR>]],
        options
    )
    keymap(
        'n',
        '<localleader>as',
        [[<Cmd> Telescope lsp_document_symbols<CR>]],
        options
    )
    keymap(
        'n',
        '<localleader>aw',
        [[<Cmd> Telescope lsp_workspace_symbols<CR>]],
        options
    )

    keymap(
        'n',
        '<leader>ds',
        [[<Cmd>lua require('tagusnvim.plugins.telescope').search_dotfiles()<CR>]],
        options
    )
    keymap(
        'n',
        '<leader>ws',
        [[<Cmd>lua require('tagusnvim.plugins.telescope').search_notes()<CR>]],
        options
    )
end

return M
