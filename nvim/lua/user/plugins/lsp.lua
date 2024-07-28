local has_words_before = function()
    local line, col = unpack(vim.api.nvim_win_get_cursor(0))
    return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match('%s') == nil
end

local feedkey = function(key, mode)
    vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes(key, true, true, true), mode, true)
end

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
        dependencies = { 'williamboman/mason.nvim' },
        opts = {
            handlers = {
                function(server_name)
                    local server_config = require('user.lsp.server_config')[server_name]
                    server_config = server_config ~= nil and server_config or {}
                    server_config.capabilities = require('cmp_nvim_lsp').default_capabilities()
                    require('lspconfig')[server_name].setup(server_config)
                end,
            },
        },
    },

    {
        'neovim/nvim-lspconfig',
        dependencies = { 'williamboman/mason-lspconfig.nvim' },
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
            vim.fn.sign_define('DiagnosticSignError', { text = diag_icons.error, texthl = 'DiagnosticSignError' })
            vim.fn.sign_define('DiagnosticSignWarn',  { text = diag_icons.warn,  texthl = 'DiagnosticSignWarn'  })
            vim.fn.sign_define('DiagnosticSignInfo',  { text = diag_icons.info,  texthl = 'DiagnosticSignInfo'  })
            vim.fn.sign_define('DiagnosticSignHint',  { text = diag_icons.hint,  texthl = 'DiagnosticSignHint'  })
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
                enable = true,
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
            vim.diagnostic.config { virtual_text = false }
            require('corn').setup(opts)
        end
    },

    {
        'hrsh7th/nvim-cmp',
        dependencies = {
            'hrsh7th/cmp-nvim-lsp',
            'hrsh7th/cmp-nvim-lsp-signature-help',
            {
                'hrsh7th/cmp-vsnip',
                dependencies = { 'hrsh7th/vim-vsnip' },
            },
            'hrsh7th/cmp-path',
            'onsails/lspkind.nvim',
        },
        event = 'InsertEnter',
        opts = function()
            local cmp = require('cmp')
            local lspkind = require('lspkind')
            return {
                preselect = cmp.PreselectMode.None,
                snippet = {
                    expand = function(args)
                        vim.fn['vsnip#anonymous'](args.body)
                    end,
                },
                mapping = {
                    -- If nothing is selected (including preselections) add a newline as usual.
                    -- If something has explicitly been selected by the user, select it.
                    ['<CR>'] = cmp.mapping({
                        i = function(fallback)
                            if cmp.visible() and cmp.get_active_entry() then
                                cmp.confirm({ behavior = cmp.ConfirmBehavior.Replace, select = false })
                            else
                                fallback()
                            end
                        end,
                        s = cmp.mapping.confirm({ select = true }),
                        c = cmp.mapping.confirm({ behavior = cmp.ConfirmBehavior.Replace, select = false }),
                    }),
                    ['<C-j>'] = cmp.mapping.select_next_item(),
                    ['<C-k>'] = cmp.mapping.select_prev_item(),

                    -- Super tab
                    ['<Tab>'] = cmp.mapping(function(fallback)
                        if cmp.visible() then
                            if #cmp.get_entries() == 1 then
                                cmp.confirm({ select = true })
                            else
                                cmp.select_next_item()
                            end
                        elseif vim.fn['vsnip#available'](1) == 1 then
                            feedkey('<Plug>(vsnip-expand-or-jump)', '')
                        elseif has_words_before() then
                            cmp.complete()
                        else
                            fallback() -- The fallback function sends a already mapped key. In this case, it's probably `<Tab>`.
                        end
                    end, { 'i', 's' }),

                    ['<S-Tab>'] = cmp.mapping(function()
                        if cmp.visible() then
                            cmp.select_prev_item()
                        elseif vim.fn['vsnip#jumpable'](-1) == 1 then
                            feedkey('<Plug>(vsnip-jump-prev)', '')
                        end
                    end, { 'i', 's' }),
                },
                sources = {
                    { name = 'nvim_lsp' },
                    { name = 'nvim_lsp_signature_help' },
                    { name = 'vsnip' },
                    { name = 'buffer' },
                    { name = 'path' },
                },
                formatting = {
                    fields = { 'abbr', 'kind', 'menu' },
                    format = lspkind.cmp_format({
                        before = function(entry, vim_item)
                            vim_item.menu = ({
                                nvim_lsp = '[LSP]',
                                vsnip = '[Snippet]',
                                buffer = '[Buffer]',
                                path = '[Path]',
                            })[entry.source.name]
                            return vim_item
                        end,
                    }),
                },
                window = {
                    documentation = {
                        border = { '╭', '─', '╮', '│', '╯', '─', '╰', '│' },
                    },
                },
            }
        end,
        config = function(_, opts)
            vim.opt.completeopt = 'menu,menuone,noselect'
            require('cmp').setup(opts)
        end,
    },
}
