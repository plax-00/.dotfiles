local colors = {
    '#E5E510',  --yellow
    '#D670D6',  --purple
    '#3B8EEA',  --blue
    '#E5E510',  --yellow
    '#D670D6',  --purple
    '#3B8EEA',  --blue
    -- '#F14C4C',  --red
    -- '#29B8DB',  --cyan
}

require('nvim-treesitter.configs').setup {
    ensure_installed = { 'python', 'javascript', 'typescript', 'vue', 'vim', 'lua', 'css', 'html', 'json', 'c', 'bash' },
    highlight = { enable = true },
    incremental_selection = { enable = true },
    rainbow = {
        enable = true,
        extended_mode = true,
        colors = colors,
    },
}

vim.opt.foldmethod = 'expr'
vim.opt.foldexpr = 'nvim_treesitter#foldexpr()'

