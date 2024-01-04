return {
    {
        'kdheepak/lazygit.nvim',
        dependencies = { 'nvim-lua/plenary.nvim' },
        cmd = 'LazyGit',
    },

    {
        'lewis6991/gitsigns.nvim',
        opts = {
            signs = {
                changedelete = {hl = 'GitSignsChange', text = '┃', numhl='GitSignsChangeNr', linehl='GitSignsChangeLn' },
            },
            attach_to_untracked =  false,
        },
    },
}
