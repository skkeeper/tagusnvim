local M = {}

M.bootstrap = function()
    require('luasnip.loaders.from_vscode').load({ paths = { './snippets' } })
end

return M
