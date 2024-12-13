return {
    {
        'folke/tokyonight.nvim',
        enabled = false,
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
            vim.cmd[[ highlight! link CursorLineNr Normal ]]
        end
    },

    {
        'EdenEast/nightfox.nvim',
        enabled = true,
        lazy = false,
        priority = 1000,
        config = function()
            vim.cmd.colorscheme('duskfox')
        end
    },

    {
        'getomni/neovim',
        enabled = false,
        lazy = false,
        priority = 1000,
        config = function()
            vim.cmd.colorscheme('omni')
        end
    },
}
