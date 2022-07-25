local M = {}

M.bootstrap = function()
    local cmp = require('cmp')

    local t = function(str)
        return vim.api.nvim_replace_termcodes(str, true, true, true)
    end

    local check_back_space = function()
        local col = vim.fn.col('.') - 1
        return col == 0 or vim.fn.getline('.'):sub(col, col):match('%s') ~= nil
    end

    cmp.setup({
        formatting = {
            format = function(entry, vim_item)
                -- fancy icons and a name of kind
                vim_item.kind = require('lspkind').presets.default[vim_item.kind]
                    .. ' '
                    .. vim_item.kind
                -- set a name for each source
                vim_item.menu = ({
                    nvim_lsp = '[LSP]',
                    nvim_lua = '[Lua]',
                    luasnip = '[✂]',
                    path = '[Path]',
                    buffer = '[Buffer]',
                    spell = '[Spell]',
                    calc = '[Calc]',
                })[entry.source.name]
                return vim_item
            end,
        },
        mapping = {
            ['<C-p>'] = cmp.mapping.select_prev_item(),
            ['<C-n>'] = cmp.mapping.select_next_item(),
            ['<C-k>'] = cmp.mapping.select_prev_item(),
            ['<C-j>'] = cmp.mapping.select_next_item(),
            ['<C-d>'] = cmp.mapping.scroll_docs(-4),
            ['<C-f>'] = cmp.mapping.scroll_docs(4),
            ['<C-Space>'] = cmp.mapping.complete(),
            ['<C-e>'] = cmp.mapping.abort(),
            ['<CR>'] = cmp.mapping.confirm({
                behavior = cmp.ConfirmBehavior.Insert,
                select = true,
            }),
            ['<Tab>'] = cmp.mapping(function(fallback)
                local luasnip = require('luasnip')
                if vim.fn.pumvisible() == 1 then
                    vim.fn.feedkeys(t('<C-n>'), 'n')
                elseif luasnip.expand_or_jumpable() then
                    luasnip.expand_or_jump()
                elseif check_back_space() then
                    vim.fn.feedkeys(t('<tab>'), 'n')
                else
                    fallback()
                end
            end, { 'i', 's' }),
            ['<S-Tab>'] = cmp.mapping(function(fallback)
                if vim.fn.pumvisible() == 1 then
                    vim.fn.feedkeys(t('<C-p>'), 'n')
                else
                    fallback()
                end
            end, { 'i', 's' }),
        },
        sources = {
            { name = 'nvim_lsp' },
            { name = 'nvim_lua' },
            { name = 'luasnip' },
            { name = 'path' },
            { name = 'buffer' },
            { name = 'spell' },
            { name = 'calc' },
        },
        completion = { completeopt = 'menu,menuone,noinsert' },
        snippet = {
            expand = function(args)
                require('luasnip').lsp_expand(args.body)
            end,
        },
    })

    -- Autopairs
    local cmp_autopairs = require('nvim-autopairs.completion.cmp')
    cmp.event:on(
        'confirm_done',
        cmp_autopairs.on_confirm_done({ map_char = { tex = '' } })
    )
end

return M
