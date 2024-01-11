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
            numhl = true,
        },
        init = function()
            vim.cmd([[
                nnoremap    <Leader>gl      <Cmd>Gitsigns toggle_linehl<CR>
                nnoremap    <Leader>gd      <Cmd>Gitsigns toggle_word_diff<CR>
            ]])
        end,
    },
}
