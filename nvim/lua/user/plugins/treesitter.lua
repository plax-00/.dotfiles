return {
    'nvim-treesitter/nvim-treesitter',
    main = 'nvim-treesitter.configs',
    build = ':TSUpdate',
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
}
