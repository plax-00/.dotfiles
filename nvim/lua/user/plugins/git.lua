return {
    {
        'lewis6991/gitsigns.nvim',
        opts = {
            signs = {
                changedelete = { hl = 'GitSignsChange', text = '┃', numhl='GitSignsChangeNr', linehl='GitSignsChangeLn' },
            },
            numhl = true,
        },
        init = function()
            vim.cmd([[
                nnoremap    <Leader>gl      <Cmd>Gitsigns toggle_linehl<CR>
            ]])
        end,
    },

    {
        'akinsho/git-conflict.nvim',
        version = '*',
        opts = {
            disable_diagnostics = true,
        },
    },

    {
        'kdheepak/lazygit.nvim',
        dependencies = { 'nvim-lua/plenary.nvim' },
        cmd = 'LazyGit',
    },

}
