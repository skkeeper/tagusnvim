local buf

function run_goplainrest(args)
    if buf == nil or not vim.api.nvim_buf_is_loaded(buf) then
        old_win = vim.api.nvim_get_current_win()
        vim.api.nvim_command('below split')
        new_win = vim.api.nvim_get_current_win()
        vim.api.nvim_set_current_win(old_win)
        buf = vim.api.nvim_create_buf(false, true)
        vim.api.nvim_win_set_buf(new_win, buf)

        vim.api.nvim_buf_set_name(buf, 'goplainrest OUTPUT')

        vim.api.nvim_buf_set_option(buf, 'buftype', 'nofile')
        vim.api.nvim_buf_set_option(buf, 'swapfile', false)
        vim.api.nvim_buf_set_option(buf, 'bufhidden', 'wipe')
        vim.api.nvim_buf_set_option(buf, 'filetype', 'nvim-oldfile')

        vim.api.nvim_win_set_option(new_win, 'wrap', false)
        vim.api.nvim_win_set_option(new_win, 'cursorline', true)
    end

    vim.api.nvim_buf_set_lines(buf, 0, -1, false, {})
    vim.fn.jobstart({
        'goplainrest',
        '-request',
        args.fargs[1],
        '-environment',
        args.fargs[2],
    }, {
        stdout_buffered = false,
        stderr_buffered = false,
        on_stdout = function(_, data)
            if data then
                vim.api.nvim_buf_set_lines(buf, -2, -1, false, data)
            end
        end,
        on_stderr = function(_, data)
            if data then
                vim.api.nvim_buf_set_lines(buf, -2, -1, false, data)
            end
        end,
    })
end

vim.api.nvim_create_user_command(
    'Goplainrest',
    run_goplainrest,
    { nargs = '*' }
)
