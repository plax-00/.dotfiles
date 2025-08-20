return {
    'stevearc/oil.nvim',
    cond = vim.env.NVIM_OIL == '1',
    opts = {
        columns = {
            'size',
            'icon',
        }
    },
}
