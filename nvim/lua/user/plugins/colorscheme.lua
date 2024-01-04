return {
    {
        'Mofiqul/vscode.nvim',
        lazy = false,
        priority = 1000,
        config = function()
            vim.cmd([[
                let g:vscode_transparency = 1
                let g:vscode_disable_nvimtree_bg = v:true
                colorscheme vscode
            ]])
        end,
    }
}
