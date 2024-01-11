return {
    'folke/noice.nvim',
    enabled = true,
    dependencies = {
        'MunifTanjim/nui.nvim',
        -- 'rcarriga/nvim-notify',
    },
    event = 'VeryLazy',
    opts = {
        lsp = {
        -- override markdown rendering so that **cmp** and other plugins use **Treesitter**
            override = {
                ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
                ["vim.lsp.util.stylize_markdown"] = true,
                ["cmp.entry.get_documentation"] = true,
            },
        },
        -- you can enable a preset for easier configuration
        presets = {
            bottom_search = true,            -- use a classic bottom cmdline for search
            command_palette = true,          -- position the cmdline and popupmenu together
            long_message_to_split = true,    -- long messages will be sent to a split
            inc_rename = false,              -- enables an input dialog for inc-rename.nvim
            lsp_doc_border = false,          -- add a border to hover docs and signature help
        },
        cmdline = {
            format = {
                help = { pattern = { "^:%s*he?l?p?%s+", ":%s*tab%s*he?l?p?%s+" }, icon = "" },
            }
        },
        commands = {
            history = {
                view = 'popup',
            },
        },
        views = {
            popup = {
                win_options = {
                    winhighlight = { Normal = 'Normal' },
                },
            },
            hover = {
                win_options = {
                    winhighlight = { Normal = 'NoicePopup' },
                },
            },
        },
    },
    config = function(_, opts)
        require('noice').setup(opts)
        vim.cmd.cabbrev('n', 'Noice')
        vim.cmd.cabbrev('h', 'tab help')
    end,
}
