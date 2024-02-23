local has_words_before = function()
    local line, col = unpack(vim.api.nvim_win_get_cursor(0))
    return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
end

local feedkey = function(key, mode)
    vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes(key, true, true, true), mode, true)
end

local kind_icons = {
    Text = "󰉿",
    Method = "m",
    Function = "󰊕",
    Constructor = "",
    Field = "",
    Variable = "󰆧",
    Class = "󰌗",
    Interface = "",
    Module = "",
    Property = "",
    Unit = "",
    Value = "󰎠",
    Enum = "",
    Keyword = "󰌋",
    Snippet = "",
    Color = "󰏘",
    File = "󰈙",
    Reference = "",
    Folder = "󰉋",
    EnumMember = "",
    Constant = "󰇽",
    Struct = "",
    Event = "",
    Operator = "󰆕",
    TypeParameter = "󰊄",
}


return {
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
                    require("lspconfig")[server_name].setup(server_config)
                end,
            },
        }
    },

    {
        'neovim/nvim-lspconfig',
        dependencies = { 'williamboman/mason-lspconfig.nvim' },
        init = function()
            -- diagnostics in hover
            vim.diagnostic.config {
                virtual_text = false,
            }
            vim.o.signcolumn = 'yes'
            vim.cmd [[autocmd MiscAutocmds CursorHold * lua vim.diagnostic.open_float(nil, {focus=false})]]
            if vim.version().minor >= 10 then
                vim.api.nvim_set_keymap( 'n', '<F3>', '', {
                    callback = function()
                        vim.lsp.inlay_hint.enable(0, not vim.lsp.inlay_hint.is_enabled())
                    end,
                    noremap = true,
                })
            end

            -- diagnostic icons
            vim.cmd [[
                sign define DiagnosticSignError text= texthl=DiagnosticSignError linehl= numhl=
                sign define DiagnosticSignWarn text= texthl=DiagnosticSignWarn linehl= numhl=
                sign define DiagnosticSignInfo text= texthl=DiagnosticSignInfo linehl= numhl=
                sign define DiagnosticSignHint text= texthl=DiagnosticSignHint linehl= numhl=
            ]]
        end,
    },

    {
        'nvimdev/lspsaga.nvim',
        enabled = false,
        event = 'LspAttach',
        opts = {
            symbol_in_winbar = {
                enable = true,
            },
            ui = {
                -- kind = kind_icons,
            },
        },
        init = function()
            vim.o.keywordprg = ':Lspsaga lsp_finder'
            vim.cmd([[
                nnoremap <Leader>O <Cmd>Lspsaga outline<CR>
            ]])
        end,
    },

    {
        'hrsh7th/nvim-cmp',
        dependencies = {
            'hrsh7th/cmp-nvim-lsp',
            'hrsh7th/cmp-nvim-lsp-signature-help',
            {
                'hrsh7th/cmp-vsnip',
                dependencies = { 'hrsh7th/vim-vsnip' }
            },
            'hrsh7th/cmp-path',
        },
        event = 'InsertEnter',
        opts = function()
            local cmp = require('cmp')
            return {
                snippet = {
                    expand = function(args)
                        vim.fn['vsnip#anonymous'](args.body)
                    end,
                },
                mapping = {
                    ['<CR>'] = cmp.mapping.confirm { select = false },
                    ['<C-j>'] = cmp.mapping.select_next_item(),
                    ['<C-k>'] = cmp.mapping.select_prev_item(),

                    -- Super tab
                    ["<Tab>"] = cmp.mapping(function(fallback)
                        if cmp.visible() then
                            cmp.select_next_item()
                        elseif vim.fn["vsnip#available"](1) == 1 then
                            feedkey("<Plug>(vsnip-expand-or-jump)", "")
                        elseif has_words_before() then
                            cmp.complete()
                        else
                            fallback() -- The fallback function sends a already mapped key. In this case, it's probably `<Tab>`.
                        end
                    end, { "i", "s" }),

                    ["<S-Tab>"] = cmp.mapping(function()
                        if cmp.visible() then
                            cmp.select_prev_item()
                        elseif vim.fn["vsnip#jumpable"](-1) == 1 then
                            feedkey("<Plug>(vsnip-jump-prev)", "")
                        end
                    end, { "i", "s" }),
                },
                sources = {
                    { name = 'nvim_lsp' },
                    { name = 'nvim_lsp_signature_help' },
                    { name = 'vsnip' },
                    { name = 'buffer' },
                    { name = 'path' },
                },
                formatting = {
                    fields = { "kind", "abbr", "menu" },
                    format = function(entry, vim_item)
                        vim_item.kind = string.format("%s", kind_icons[vim_item.kind])
                        vim_item.menu = ({
                            nvim_lsp = '[LSP]',
                            vsnip = '[Snippet]',
                            buffer = '[Buffer]',
                            path = '[Path]',
                        })[entry.source.name]
                        return vim_item
                    end,
                },
                window = {
                    documentation = {
                        border = { "╭", "─", "╮", "│", "╯", "─", "╰", "│" },
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
