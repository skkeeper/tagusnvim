local is_present = function(command)
    vim.fn.system(command)
    return vim.v.shell_error == 0
end

return is_present
