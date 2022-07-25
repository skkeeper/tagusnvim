-- Bootstrap
local fn = vim.fn
local install_path = fn.stdpath('data') .. '/site/pack/packer/start/packer.nvim'
if fn.empty(fn.glob(install_path)) > 0 then
    packer_bootstrap = fn.system({
        'git',
        'clone',
        '--depth',
        '1',
        'https://github.com/wbthomason/packer.nvim',
        install_path,
    })
    vim.cmd([[packadd packer.nvim]])
end

return require('packer').startup(function(use)
    use('wbthomason/packer.nvim')

    -- Delete buffer but respect layout
    use('famiu/bufdelete.nvim')
    -- Delete hidden buffers
    use('arithran/vim-delete-hidden-buffers')
    -- Better quickfix
    use({
        'kevinhwang91/nvim-bqf',
        requires = {
            {
                'junegunn/fzf',
                run = function()
                    vim.fn['fzf#install']()
                end,
            },
        },
    })

    -- Editor config support
    use('gpanders/editorconfig.nvim')

    -- Sidebar for file tree
    use({
        'nvim-neo-tree/neo-tree.nvim',
        branch = 'v2.x',
        requires = {
            'nvim-lua/plenary.nvim',
            'kyazdani42/nvim-web-devicons',
            'MunifTanjim/nui.nvim',
        },
    })

    use({
        'numToStr/Comment.nvim',
        tag = 'v0.6.1',
    })

    -- Highlight color codes in buffers
    use({
        'norcalli/nvim-colorizer.lua',
        -- event = 'BufRead',
    })

    -- Treesitter syntax
    use({
        'nvim-treesitter/nvim-treesitter',
        requires = {
            'nvim-treesitter/nvim-treesitter-textobjects',
            {
                -- Parenthesis highlighting
                'p00f/nvim-ts-rainbow',
                after = 'nvim-treesitter',
            },
            {
                -- Autoclose tags
                'windwp/nvim-ts-autotag',
                after = 'nvim-treesitter',
            },
            {
                -- Context based commenting
                'JoosepAlviste/nvim-ts-context-commentstring',
                after = 'nvim-treesitter',
            },
        },
        run = ':TSUpdate',
    })

    -- show function/method context name on fold close
    use({ 'haringsrob/nvim_context_vt', after = 'nvim-treesitter' })

    -- show indent indicators on all lines
    use({
        'lukas-reineke/indent-blankline.nvim',
        -- event = 'BufRead',
    })

    -- JSON Schema validators
    use('b0o/schemastore.nvim')

    -- LSP auto installer and configurations
    use({
        'williamboman/mason.nvim',
        'williamboman/mason-lspconfig.nvim',
        'WhoIsSethDaniel/mason-tool-installer.nvim',
        'neovim/nvim-lspconfig',
        'jose-elias-alvarez/typescript.nvim',
        'nvim-lua/lsp-status.nvim',
        'ray-x/lsp_signature.nvim',
    })

    -- Integrate cli tools into LSP
    use({
        'jose-elias-alvarez/null-ls.nvim',
        requires = { 'nvim-lua/plenary.nvim' },
    })

    use({
        'https://git.sr.ht/~whynothugo/lsp_lines.nvim',
        config = function()
            require('lsp_lines').setup()
        end,
    })

    -- LSP extensions and UIs
    use({
        'glepnir/lspsaga.nvim',
    })

    -- Swap function parameters command
    use('mizlan/iswap.nvim')

    -- Quickfix list for diagnostics
    use({
        'folke/trouble.nvim',
        requires = 'kyazdani42/nvim-web-devicons',
    })

    -- Highlight TODO comments
    use({
        'folke/todo-comments.nvim',
        requires = 'nvim-lua/plenary.nvim',
    })

    -- Autopairs for tags
    use('windwp/nvim-autopairs')

    -- Snippets
    use('L3MON4D3/LuaSnip')

    -- Auto complete
    use({
        'hrsh7th/nvim-cmp',
        requires = {
            'onsails/lspkind-nvim',
            'hrsh7th/cmp-buffer',
            'hrsh7th/cmp-nvim-lsp',
            'hrsh7th/cmp-nvim-lua',
            'hrsh7th/cmp-path',
            'hrsh7th/cmp-calc',
            'f3fora/cmp-spell',
            'L3MON4D3/LuaSnip',
            'saadparwaiz1/cmp_luasnip',
        },
        after = {
            'nvim-autopairs',
            'LuaSnip',
        },
    })

    -- Buffer line
    use({
        'romgrk/barbar.nvim',
        -- event = 'VimEnter', -- fixes nvim intro
        requires = { 'kyazdani42/nvim-web-devicons' },
    })

    use({
        'SmiteshP/nvim-navic',
        requires = 'neovim/nvim-lspconfig',
    })

    use('feline-nvim/feline.nvim')

    -- Colorscheme
    use({
        'catppuccin/nvim',
        as = 'catppuccin',
    })

    -- Telescope
    use({
        'nvim-telescope/telescope-fzf-native.nvim',
        run = 'cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release && cmake --install build --prefix build',
    })
    use({
        'nvim-telescope/telescope.nvim',
        requires = {
            'nvim-lua/popup.nvim',
            'nvim-lua/plenary.nvim',
            'kyazdani42/nvim-web-devicons',
            'nvim-telescope/telescope-live-grep-args.nvim',
        },
        after = { 'telescope-fzf-native.nvim', 'trouble.nvim' },
    })

    -- git symbols in the gutter
    use({
        'lewis6991/gitsigns.nvim',
        requires = { 'nvim-lua/plenary.nvim' },
    })
    -- git full bootstrap
    use({ 'idanarye/vim-merginal', requires = 'tpope/vim-fugitive' })
    -- git commit browser
    use({ 'junegunn/gv.vim', requires = 'tpope/vim-fugitive' })
    -- git diff view
    use({ 'sindrets/diffview.nvim', requires = 'nvim-lua/plenary.nvim' })

    -- Documentation generator
    use({ 'kkoomen/vim-doge', run = ':call doge#install()' })

    -- run async commands inside nvim
    use('tpope/vim-dispatch')

    -- scrollbar
    use({
        'petertriho/nvim-scrollbar',
        -- event = 'BufRead', -- fix nvim intro
    })

    -- Testing integration
    use({ 'vim-test/vim-test', run = ':UpdateRemotePlugins' })
    use({
        'nvim-neotest/neotest',
        requires = {
            'nvim-lua/plenary.nvim',
            'nvim-treesitter/nvim-treesitter',
            'antoinemadec/FixCursorHold.nvim',
            'vim-test/vim-test',
            'haydenmeade/neotest-jest',
            'nvim-neotest/neotest-plenary',
            'nvim-neotest/neotest-vim-test',
        },
    })

    -- help screens for keymaps
    use('folke/which-key.nvim')

    if packer_bootstrap then
        require('packer').sync()
    end
end, {
    display = {
        border = { '┌', '─', '┐', '│', '┘', '─', '└', '│' },
    },
})
