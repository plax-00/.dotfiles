return {
    {
        'stevearc/dressing.nvim',
        event = 'VeryLazy',
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
            scope = { enabled = false },
        },
    },

    {
        'nvim-lualine/lualine.nvim',
        opts = {
            options = {
                icons_enabled = false,
            },
            sections = {
                lualine_x = { '%8.10S', 'encoding', 'filetype' },
            },
            extensions = { 'nvim-tree' },
        },
        config = function(_, opts)
            vim.o.showcmdloc = 'statusline'
            require('lualine').setup(opts)
        end,
    },

    {
        'ggandor/leap.nvim',
        config = function()
            require('leap').add_default_mappings()
        end,
    },

    {
        'echasnovski/mini.ai',
        dependencies = { 'nvim-treesitter/nvim-treesitter-textobjects' },
        opts = function()
            local gen_spec = require('mini.ai').gen_spec
            return {
                custom_textobjects = {
                    F = gen_spec.treesitter { a = '@function.outer', i = '@function.inner' },
                    o = gen_spec.treesitter {
                        a = { '@conditional.outer', '@loop.outer' },
                        i = { '@conditional.inner', '@loop.inner' },
                    },
                },
            }
        end,
    },

    {
        'echasnovski/mini.splitjoin',
        opts = function()
            local gen_hook = require('mini.splitjoin').gen_hook
            return {
                split = {
                    hooks_post = { gen_hook.add_trailing_separator() },
                },
                join = {
                    hooks_post = { gen_hook.del_trailing_separator(), gen_hook.pad_brackets() },
                },
            }
        end,
    },

    {
        'kawre/neotab.nvim',
        opts = {
            tabkey = '<C-l>',
            act_as_tab = false,
        }
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
        config = function(_, opts)
            local rainbow_delimiters = require('rainbow-delimiters')
            vim.api.nvim_create_augroup('RainbowDelimitersReload', { clear = true })
            vim.api.nvim_create_autocmd('BufWritePost', { callback = function()
                rainbow_delimiters.disable()
                rainbow_delimiters.enable()
            end })
            require('rainbow-delimiters.setup').setup(opts)
        end
    },

    {
        'MeanderingProgrammer/render-markdown.nvim',
        config = true,
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
}
