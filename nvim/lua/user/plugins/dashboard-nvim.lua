local center = {
    {
        icon = ' ',
        desc = 'Search Directory         ',
        key = 'f',
        action = 'Telescope find_files hidden=true theme=dropdown prompt_title=Search\\ Directory',
        icon_hl = '@keyword', desc_hl = '@function', key_hl = '@string',
    },
    {
        icon = '󰈢 ',
        desc = 'Recent Files             ',
        key = 'o',
        action = 'Telescope oldfiles hidden=true theme=dropdown prompt_title=Recent\\ Files',
        icon_hl = '@keyword', desc_hl = '@function', key_hl = '@string',
    },
    {
        icon = '󰈞 ',
        desc = 'Grep Files               ',
        key = 'g',
        action = 'Telescope live_grep hidden=true theme=dropdown prompt_title=Grep\\ Files',
        icon_hl = '@keyword', desc_hl = '@function', key_hl = '@string',
    },
    {
        icon = ' ',
        desc = 'File Explorer            ',
        key = 'e',
        action = 'Oil .',
        icon_hl = '@keyword', desc_hl = '@function', key_hl = '@string',
    },
    {
        icon = ' ',
        desc = 'Quit                     ',
        key = 'q',
        action = 'q',
        icon_hl = '@keyword', desc_hl = '@function', key_hl = '@string',
    },
}

local function pad_header(header, top, bottom)
    local result = {}

    vim.list_extend(result, vim.fn['repeat']({ '' }, top))
    vim.list_extend(result, header)
    vim.list_extend(result, vim.fn['repeat']({ '' }, bottom))

    return result
end

return {
    'nvimdev/dashboard-nvim',
    cond = function()
        local sessions = require('user.sessions')
        return not vim.uv.fs_stat(sessions.get_session_file())
    end,
    opts = function()
        local header = pad_header(require('ascii').art.text.neovim.sharp, 4, 8)
        return {
            theme = 'doom',
            config = {
                header = header,
                center = center,
            },
        }
    end,
}
