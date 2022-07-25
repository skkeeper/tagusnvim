local M = {}

M.keybindings = function()
    local keymap = vim.api.nvim_set_keymap
    local options = { noremap = true, silent = true }
    keymap('n', '<leader>gs', ':G<CR>', options)
    keymap('n', '<leader>gj', ':diffget //3<CR>', options)
    keymap('n', '<leader>gf', ':diffget //2<CR>', options)
    keymap('n', '<leader>gr', ':Gremove<CR>', options)
    keymap('n', '<leader>gh', ':Git push<CR>', options)
    keymap('n', '<leader>gc', ':Git commit<CR>', options)
    -- map('n', '<leader>gd', ':Git difftool<CR>')
    keymap('n', '<leader>gp', ':Git pull<CR>', options)
    -- map('n', '<leader>gl', ':Git log<CR>')

    keymap('n', '<localleader>d', ':Gdiffsplit<CR>', options)
    keymap('n', '<localleader>b', ':Gblame<CR>', options)
    -- map('n', '<localleader>l', ':0Gclog<CR>')
end

return M
