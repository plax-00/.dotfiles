return {
    'nvim-treesitter/nvim-treesitter',
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
    config = function(_, opts)
        require('nvim-treesitter.configs').setup(opts)
        vim.o.foldmethod = 'expr'
        vim.o.foldexpr = 'nvim_treesitter#foldexpr()'
    end,
}
