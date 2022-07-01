local lspconfig = require('lspconfig')
local lsp_installer = require('nvim-lsp-installer')

lsp_installer.setup {}

local cmp = require('user.lsp.cmp')

-- diagnostics in hover
vim.diagnostic.config {
    virtual_text = false,
}
vim.o.signcolumn = 'yes'
vim.o.updatetime = 1000
vim.cmd [[autocmd CursorHold * lua vim.diagnostic.open_float(nil, {focus=false})]]

-- diagnostic icons
vim.cmd([[
    sign define DiagnosticSignError text= texthl=DiagnosticSignError linehl= numhl=
    sign define DiagnosticSignWarn text= texthl=DiagnosticSignWarn linehl= numhl=
    sign define DiagnosticSignInfo text= texthl=DiagnosticSignInfo linehl= numhl=
    sign define DiagnosticSignHint text= texthl=DiagnosticSignHint linehl= numhl=
]])


-- language server setups
for _, server in ipairs(lsp_installer.get_installed_servers()) do
    lspconfig[server.name].setup {
        capabilities = cmp.capabilities
    }
end

-- additional settings
lspconfig.eslint.setup {
    filetypes = { "javascript", "javascriptreact", "javascript.jsx", "typescript", "typescriptreact", "typescript.tsx" },
}

lspconfig.sumneko_lua.setup {
    settings = {
        Lua = {
            diagnostics = {
                globals = { 'vim' },
            },
        },
    },
}

