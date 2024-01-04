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

return {
    'nvim-treesitter/nvim-treesitter',
    build = ':TSUpdate',
    -- dependencies = { 'p00f/nvim-ts-rainbow' },
    opts = {
        ensure_installed = {
            'bash',
            'c',
            'css',
            'html',
            'javascript',
            'json',
            'lua',
            'markdown',
            'markdown_inline',
            'python',
            'regex',
            'rust',
            'typescript',
            'vim',
            'vimdoc',
            'vue'
        },
        highlight = { enable = true },
        incremental_selection = { enable = true },
    },
    config = function(_, opts)
        require('nvim-treesitter.configs').setup(opts)
        vim.o.foldmethod = 'expr'
        vim.o.foldexpr = 'nvim_treesitter#foldexpr()'
    end,
}
