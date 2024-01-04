return {
    {
        'akinsho/bufferline.nvim',
        version = '*',
        dependencies = { 'nvim-tree/nvim-web-devicons' },
        opts = {
            options = {
                numbers = 'buffer_id',
                show_buffer_close_icons = false,
                show_close_icon = false,
                diagnostics = 'nvim_lsp',
                offsets = {
                    { filetype = 'NvimTree', text = 'File Explorer', highlight = 'Directory' },
                },
            }
        },
        init = function()
            vim.o.showtabline = 2
        end,
    },

    {
        'plax-00/endscroll.nvim',
        dev = true,
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
            scope = {
                show_start = false,
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
        'HiPhish/rainbow-delimiters.nvim',
        opts = {
            highlight = {
                'RainbowDelimiterYellow',
                'RainbowDelimiterViolet',
                'RainbowDelimiterBlue',
                'RainbowDelimiterRed',
            },
        },
        config = function(_, opts)
            require('rainbow-delimiters.setup').setup(opts)
            vim.cmd([[
                highlight RainbowDelimiterYellow guifg=#e5e510
                highlight RainbowDelimiterViolet guifg=#d670d6
                highlight RainbowDelimiterBlue guifg=#3b8eea
                highlight RainbowDelimiterRed guifg=#f14c4c
            ]])
        end,
    },
    
    {
        'declancm/cinnamon.nvim',
        enabled = false,
        opts = {
            extra_keymaps = true,
            override_keymaps = true,
        },
    },
}