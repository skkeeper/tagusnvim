local M = {}

M.bootstrap = function()
    require('colorizer').setup({})
    vim.cmd('ColorizerAttachToBuffer')
    vim.cmd('ColorizerReloadAllBuffers')
end

return M
