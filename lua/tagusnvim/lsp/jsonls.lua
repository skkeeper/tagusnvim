local M = {}

M.generate_opts = function()
    local schemastore = require('schemastore')
    local opts = {
        init_options = {
            provideFormatter = false,
        },
        settings = {
            json = {
                schemas = schemastore.json.schemas(),
                validate = { enable = true }
            },
        },
    }

    return opts
end

return M
