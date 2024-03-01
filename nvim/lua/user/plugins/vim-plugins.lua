return {
    'tpope/vim-commentary',
    'tpope/vim-surround',
    'tpope/vim-repeat',
    'jiangmiao/auto-pairs',
    'jesseleite/vim-noh',
    'jrudess/vim-foldtext',
    'jeetsukumaran/vim-indentwise',
    {
        'junegunn/vim-easy-align',
        init = function()
            vim.cmd[[
                " Start interactive EasyAlign in visual mode (e.g. vipga)
                xmap ga <Plug>(EasyAlign)

                " Start interactive EasyAlign for a motion/text object (e.g. gaip)
                nmap ga <Plug>(EasyAlign)
            ]]
        end
    },
    'tikhomirov/vim-glsl',
}
