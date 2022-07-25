function OpenURIUnderCursor()
    local function open_uri(uri)
        if type(uri) ~= 'nil' then
            uri = string.gsub(uri, '#', '\\#') --double escapes any # signs
            uri = '"' .. uri .. '"'
            vim.cmd('!xdg-open ' .. uri .. ' > /dev/null')
            vim.cmd('mode')
            -- print(uri)
            return true
        else
            return false
        end
    end

    local word_under_cursor = vim.fn.expand('<cWORD>')
    -- any uri with a protocol segment
    local regex_protocol_uri = '%a*:%/%/[%a%d%#%[%]%-%%+:;!$@/?&=_.,~*()]*'
    if open_uri(string.match(word_under_cursor, regex_protocol_uri)) then
        return
    end
    -- consider anything that looks like string/string a github link
    local regex_plugin_url = '[%a%d%-%.%_]*%/[%a%d%-%.%_]*'
    if
        open_uri(
            'https://github.com/'
                .. string.match(word_under_cursor, regex_plugin_url)
        )
    then
        return
    end
end

vim.api.nvim_create_user_command('OpenURIUnderCursor', OpenURIUnderCursor, {})
