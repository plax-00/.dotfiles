local header = {
    [[]],
    [[]],
    [[        ⢀⣴⡾⠃     ⠈⠺⠟⠛⠛⠛⠛⠻⢿⣿⣿⣿⣿⣶⣤⡀  ]],
    [[      ⢀⣴⣿⡿⠁              ⣸⣿⣿⣿⣿⣿⣿⣿⣷ ]],
    [[     ⣴⣿⡿⡟⡼⢹⣷⢲⡶⣖⣶⣶⢄      ⣼⣿⢿⣿⣿⣿⣿⣿⣿⣿ ]],
    [[    ⣾⣿⡟⣾⡸⢠⡿⢳⡿⠍⣼⣿⢏⣿⣷⢄⡀ ⢠⣾⢻⣿⣸⣿⣿⣿⣿⣿⣿⣿ ]],
    [[  ⣡⣿⣿⡟⡼⡁⠁⣰⠂⡾⠉⢨⣿⠃⣿⡿⠍⣾⣟⢤⣿⢇⣿⢇⣿⣿⢿⣿⣿⣿⣿⣿ ]],
    [[ ⣱⣿⣿⡟⡐⣰⣧⡷⣿⣴⣧⣤⣼⣯⢸⡿⠁⣰⠟⢀⣼⠏⣲⠏⢸⣿⡟⣿⣿⣿⣿⣿⣿ ]],
    [[ ⣿⣿⡟⠁ ⠟⣁⠄⢡⣿⣿⣿⣿⣿⣿⣦⣼⢟⢀⡼⠃⡹⠃⡀⢸⡿⢸⣿⣿⣿⣿⣿⡟ ]],
    [[ ⣿⣿⠃ ⢀⣾⠋⠓⢰⣿⣿⣿⣿⣿⣿⠿⣿⣿⣾⣅⢔⣕⡇⡇⡼⢁⣿⣿⣿⣿⣿⣿⢣ ]],
    [[ ⣿⡟  ⣾⣇⠷⣢⣿⣿⣿⣿⣿⣿⣿⣭⣀⡈⠙⢿⣿⣿⡇⡧⢁⣾⣿⣿⣿⣿⣿⢏⣾ ]],
    [[ ⣿⡇ ⣼⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⠟⢻⠇⠄⠄⢿⣿⡇⢡⣾⣿⣿⣿⣿⣿⣏⣼⣿ ]],
    [[ ⣿⣷⢰⣿⣿⣾⣿⣿⣿⣿⣿⣿⣿⣿⣿⢰⣧⣀⡄⢀⠘⡿⣰⣿⣿⣿⣿⣿⣿⠟⣼⣿⣿ ]],
    [[ ⢹⣿⢸⣿⣿⠟⠻⢿⣿⣿⣿⣿⣿⣿⣿⣶⣭⣉⣤⣿⢈⣼⣿⣿⣿⣿⣿⣿⠏⣾⣹⣿⣿ ]],
    [[ ⢸⠇⡜⣿⡟   ⠈⠙⣿⣿⣿⣿⣿⣿⣿⣿⠟⣱⣻⣿⣿⣿⣿⣿⠟⠁⢳⠃⣿⣿⣿ ]],
    [[  ⣰⡗⠹⣿⣄   ⢀⣿⣿⣿⣿⣿⣿⠟⣅⣥⣿⣿⣿⣿⠿⠋  ⣾⡌⢠⣿⡿⠃ ]],
    [[ ⠜⠋⢠⣷⢻⣿⣿⣶⣾⣿⣿⣿⣿⠿⣛⣥⣾⣿⠿⠟⠛⠉            ]],
    [[]],
    [[  N  E  O  V  I  M  ]],
    [[]],
    [[]],
}

local center = {
    {
        icon = ' ',
        desc = 'Search Directory         ',
        key = 'f',
        action = 'Telescope find_files hidden=true theme=dropdown prompt_title=Search\\ Directory',
    },
    {
        icon = ' ',
        desc = 'Recent Files             ',
        key = 'o',
        action = 'Telescope oldfiles hidden=true theme=dropdown prompt_title=Recent\\ Files',
    },
    {
        icon = ' ',
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


return {
    'nvimdev/dashboard-nvim',
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    opts = {
        theme = 'doom',
        config = {
            header = header,
            center = center,
        },
    },
}
