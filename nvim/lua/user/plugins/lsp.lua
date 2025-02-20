local diag_icons = {
    error = '',
    warn = '',
    info = '',
    hint = '',
}

return {
    {
        'stevearc/conform.nvim',
        event = 'LspAttach',
        opts = {
            formatters = {
                rustfmt = {
                    inherit = false,
                    command = 'cargo format',
                },
            },
            formatters_by_ft = {
                lua = { 'stylua' },
                rust = { 'rustfmt' },
                html = { 'prettier' },
                javascript = { 'prettier' },
                typescript = { 'prettier' },
            },
        },
        config = function(_, opts)
            local conform = require('conform')
            vim.keymap.set('n', '<Leader>lf', function()
                conform.format { timeout_ms = 5000 }
            end)
            conform.setup(opts)
        end
    },

    {
        'williamboman/mason.nvim',
        build = ':MasonUpdate',
        opts = {},
    },

    {
        'williamboman/mason-lspconfig.nvim',
        dependencies = {
            'williamboman/mason.nvim',
            'saghen/blink.cmp',
        },
        opts = {
            handlers = {
                function(server_name)
                    local config = require('user.lsp.server_config')[server_name] or {}
                    config.capabilities = require('blink.cmp').get_lsp_capabilities(config.capabilities)
                    require('lspconfig')[server_name].setup(config)
                end,
            },
        },
    },

    {
        'neovim/nvim-lspconfig',
        dependencies = {
            'williamboman/mason-lspconfig.nvim',
            {
                "folke/lazydev.nvim",
                ft = "lua", -- only load on lua files
                opts = {
                    library = {
                        -- See the configuration section for more details
                        -- Load luvit types when the `vim.uv` word is found
                        { path = "luvit-meta/library", words = { "vim%.uv" } },
                    },
                },
            },
        },
        config = function()
            -- <F3> to toggle inlay hints
            if vim.version().minor >= 10 then
                vim.keymap.set('n', '<F3>', function()
                    vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled())
                end)
            end

            -- <F4> to toggle diagnostic virtual text
            vim.keymap.set('n', '<F4>', function()
                local current = vim.diagnostic.config().virtual_text
                vim.diagnostic.config { virtual_text = not current }
            end)

            vim.keymap.set('n', '<Leader>r', vim.lsp.buf.rename)

            -- diagnostic icons
            if vim.version().minor >= 11 then
                vim.diagnostic.config {
                    signs = {
                        text = {
                            [vim.diagnostic.severity.ERROR] = diag_icons.error,
                            [vim.diagnostic.severity.WARN] = diag_icons.warn,
                            [vim.diagnostic.severity.INFO] = diag_icons.info,
                            [vim.diagnostic.severity.HINT] = diag_icons.hint,
                        }
                    }
                }
            else
                vim.fn.sign_define('DiagnosticSignError', { text = diag_icons.error, texthl = 'DiagnosticSignError' })
                vim.fn.sign_define('DiagnosticSignWarn',  { text = diag_icons.warn,  texthl = 'DiagnosticSignWarn'  })
                vim.fn.sign_define('DiagnosticSignInfo',  { text = diag_icons.info,  texthl = 'DiagnosticSignInfo'  })
                vim.fn.sign_define('DiagnosticSignHint',  { text = diag_icons.hint,  texthl = 'DiagnosticSignHint'  })
            end
        end,
    },

    {
        'nvimdev/lspsaga.nvim',
        dependencies = {
            'nvim-treesitter/nvim-treesitter',
            'nvim-tree/nvim-web-devicons',
        },
        event = 'LspAttach',
        opts = {
            symbol_in_winbar = {
                enable = false,
            },
            lightbulb = { enable = false },
        },
        config = function(_, opts)
            local lspsaga = require('lspsaga')
            vim.cmd [[
                nnoremap <Leader>lo  <Cmd>Lspsaga outline<CR>
                nnoremap gk          <Cmd>Lspsaga goto_definition<CR>
                nnoremap <Leader>la  <Cmd>Lspsaga code_action<CR>
                nnoremap <Leader>r   <Cmd>Lspsaga rename<CR>
            ]]

            lspsaga.setup(opts)
        end,
    },

    {
        'plax-00/corn.nvim',
        event = 'LspAttach',
        opts = {
            border_style = 'rounded',
            item_preprocess_func = function(item)
                item.source = nil
                item.code = nil
                item.lnum = nil
                item.col = nil
                return item
            end,
            icons = {
                error = diag_icons.error,
                warn = diag_icons.warn,
                info = diag_icons.info,
                hint = diag_icons.hint,
            },
        },
        config = function(_, opts)
            vim.diagnostic.config { virtual_text = true }
            require('corn').setup(opts)
        end
    },
}
