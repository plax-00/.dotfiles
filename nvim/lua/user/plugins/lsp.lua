local diag_icons = {
    error = '',
    warn = '',
    info = '',
    hint = '',
}

vim.diagnostic.config {
    virtual_lines = false,
    virtual_text = true,
}

local function toggle_virtual_lines()
    local text = vim.diagnostic.config().virtual_text
    local lines = vim.diagnostic.config().virtual_lines
    vim.diagnostic.config {
        virtual_lines = not lines,
        virtual_text = not text,
    }
end

return {
    {
        'stevearc/conform.nvim',
        event = 'LspAttach',
        opts = {
            formatters = {
                rustfmt = {
                    inherit = false,
                    command = 'cargo',
                    args = { 'fmt' }
                },
            },
            formatters_by_ft = {
                lua = { 'stylua' },
                rust = { 'rustfmt' },
                html = { 'prettier' },
                javascript = { 'prettier' },
                typescript = { 'prettier' },
                go = { 'gofmt' }
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
        'mason-org/mason-lspconfig.nvim',
        dependencies = {
            { 'mason-org/mason.nvim', opts = {} },
            'neovim/nvim-lspconfig',
            'saghen/blink.cmp',
        },
        opts = {},
    },

    {
        'neovim/nvim-lspconfig',
        dependencies = {
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


            vim.keymap.set('n', '<Leader>k', function()
                local line = vim.fn.line('.')
                local vtext = vim.diagnostic.config().virtual_text
                vim.diagnostic.config {
                    virtual_lines = { current_line = true },
                    virtual_text = false,
                }
                vim.api.nvim_create_autocmd('CursorMoved', {
                    callback = function()
                        if vim.fn.line('.') ~= line then
                            vim.diagnostic.config {
                                virtual_lines = false,
                                virtual_text = vtext,
                            }
                            return true
                        end
                    end
                })
            end)

            -- <F4> to toggle diagnostic virtual text
            vim.keymap.set('n', '<F4>', function()
                local current = vim.diagnostic.config().virtual_text
                vim.diagnostic.config { virtual_text = not current }
            end)

            vim.keymap.set('n', '<Leader>r', vim.lsp.buf.rename)

            -- diagnostic icons
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
            vim.lsp.enable('rust_analyzer')
        end,
    },

    {
        'nvimdev/lspsaga.nvim',
        dependencies = {
            'nvim-treesitter/nvim-treesitter',
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
            local corn = require('corn')
            vim.keymap.set('n', '<F4>', function()
                toggle_virtual_lines()
                corn.toggle(not vim.diagnostic.config().virtual_lines and 'on')
            end)
            corn.setup(opts)
            corn.toggle()
        end
    },
}
