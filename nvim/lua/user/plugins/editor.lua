return {
    {
        'stevearc/dressing.nvim',
        opts = {},
    },

    {
        'plax-00/endscroll.nvim',
        opts = {
            disabled_filetypes = {
                'dashboard',
                'toggleterm',
                'lazy',
                'noice',
                'NvimTree',
            },
        },
    },

    {
        'lukas-reineke/indent-blankline.nvim',
        main = 'ibl',
        opts = {
            exclude = {
                filetypes = {
                    'dashboard',
                    'lazy',
                },
            },
        },
    },

    {
        'nvim-lualine/lualine.nvim',
        init = function()
            vim.o.showcmdloc = 'statusline'
        end,
        opts = {
            options = {
                icons_enabled = false,
            },
            sections = {
                lualine_x = { '%8.10S', 'encoding', 'filetype' },
            },
            extensions = { 'nvim-tree' },
        },
    },

    {
        'ggandor/leap.nvim',
        init = function()
            require('leap').add_default_mappings()
        end,
    },

    {
        'kevinhwang91/nvim-ufo',
        main = 'ufo',
        dependencies = {
            'kevinhwang91/promise-async'
        },
        opts = {
            open_fold_hl_timeout = 0,
            provider_selector = function()
                return { 'treesitter', 'indent' }
            end,
        },
    },

    {
        'HiPhish/rainbow-delimiters.nvim',
        main = 'rainbow-delimiters.setup',
        opts = {
            highlight = {
                'RainbowDelimiterYellow',
                'RainbowDelimiterViolet',
                'RainbowDelimiterBlue',
                'RainbowDelimiterRed',
            },
        },
    },
}
