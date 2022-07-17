local db = require('dashboard')

db.custom_header = {
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

db.custom_center = {
    {
        icon = ' ',
        desc = 'Search Directory         ',
        action = 'Telescope find_files hidden=true theme=dropdown prompt_title=Search\\ Directory',
        shortcut = 'SPC f f',
    },
    {
        icon = ' ',
        desc = 'Recent Files             ',
        action = 'Telescope oldfiles hidden=true theme=dropdown prompt_title=Recent\\ Files',
        shortcut = 'SPC f o',
    },
    {
        icon = ' ',
        desc = 'Grep Files               ',
        action = 'Telescope live_grep hidden=true theme=dropdown prompt_title=Grep\\ Files',
        shortcut = 'SPC f g',
    },
    {
        icon = ' ',
        desc = 'File Explorer            ',
        action = 'NvimTreeOpen',
        shortcut = 'SPC e  ',
    },
}

db.custom_footer = {}

vim.api.nvim_command([[highlight link DashboardHeader TSFunction]])
vim.api.nvim_command([[highlight link DashboardCenterIcon TSKeyword]])
vim.api.nvim_command([[highlight link DashboardCenter TSFunction]])
vim.api.nvim_command([[highlight link DashboardShortcut TSString]])

vim.o.ruler = false
