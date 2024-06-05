local center = {
    {
        icon = ' ',
        desc = 'Search Directory         ',
        key = 'f',
        action = 'Telescope find_files hidden=true theme=dropdown prompt_title=Search\\ Directory',
    },
    {
        icon = '󰈢 ',
        desc = 'Recent Files             ',
        key = 'o',
        action = 'Telescope oldfiles hidden=true theme=dropdown prompt_title=Recent\\ Files',
    },
    {
        icon = '󰈞 ',
        desc = 'Grep Files               ',
        key = 'g',
        action = 'Telescope live_grep hidden=true theme=dropdown prompt_title=Grep\\ Files',
    },
    {
        icon = ' ',
        desc = 'File Explorer            ',
        key = 'e',
        action = 'NvimTreeOpen',
    },
    {
        icon = ' ',
        desc = 'Quit                     ',
        key = 'q',
        action = 'q',
    },
}

for _, v in pairs(center) do
    v.icon_hl = '@keyword'
    v.desc_hl = '@function'
    v.key_hl = '@string'
end

local function pad_header(header, top, bottom)
    local top_pad = {}
    local bottom_pad = {}

    for _ = 1,top do
        table.insert(top_pad, '')
    end
    for _ = 1,bottom do
        table.insert(bottom_pad, '')
    end

    vim.list_extend(top_pad, header)
    vim.list_extend(top_pad, bottom_pad)

    return top_pad
end


return {
    'nvimdev/dashboard-nvim',
    dependencies = {
        'nvim-tree/nvim-web-devicons',
        'MaximilianLloyd/ascii.nvim',
    },
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
