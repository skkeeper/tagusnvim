local M = {}

M.run_if_module_exists = function(pluginName, callback)
    if not pcall(require, pluginName) then
        return
    end
    callback()
end

M.run_if_modules_exists = function(pluginNames, callback)
    for _, v in pairs(pluginNames) do
        if not pcall(require, v) then
            return
        end
    end
    callback()
end

M.run_if_exists = function(variable, callback)
    if not vim.fn.exists(variable) == 0 then
        return
    end
    callback()
end

return M
