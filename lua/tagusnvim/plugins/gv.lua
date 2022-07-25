local M = {}

M.keybindings = function()
    local keymap = vim.api.nvim_set_keymap
    local options = { noremap = true, silent = true }
    keymap('n', '<leader>gl', ':GV<CR>', options)
    keymap('n', '<localleader>l', ':GV!<CR>', options)
end

return M
