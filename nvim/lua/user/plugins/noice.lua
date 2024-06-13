return {
    'folke/noice.nvim',
    enabled = true,
    dependencies = {
        'MunifTanjim/nui.nvim',
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
            lsp_doc_border = true,           -- add a border to hover docs and signature help
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
        local noice = require('noice')

        vim.keymap.set('n', '<Leader>m', function() noice.cmd('history') end)
        vim.cmd.cabbrev('n', 'Noice')
        vim.cmd.cabbrev('h', 'tab help')

        noice.setup(opts)
    end,
}
