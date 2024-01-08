return {
    {
        'Mofiqul/vscode.nvim',
        enabled = false,
        lazy = false,
        priority = 1000,
        config = function()
            vim.cmd([[
                let g:vscode_transparency = 1
                let g:vscode_disable_nvimtree_bg = v:true
                colorscheme vscode

                " rainbow delimiter colors
                highlight RainbowDelimiterYellow guifg=#e5e510
                highlight RainbowDelimiterViolet guifg=#d670d6
                highlight RainbowDelimiterBlue guifg=#3b8eea
                highlight RainbowDelimiterRed guifg=#f14c4c
            ]])
        end,
    },

    {
        'folke/tokyonight.nvim',
        enabled = true,
        lazy = false,
        priority = 1000,
        opts = {
            style = 'night',
            transparent = false,
            styles = {
                keywords = { italic = false },
            },
        },
        config = function(_, opts)
            require('tokyonight').setup(opts)
			vim.cmd.colorscheme('tokyonight')
        end
    }
}
