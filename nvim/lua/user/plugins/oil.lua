return {
    'stevearc/oil.nvim',
    cond = vim.env.NVIM_OIL == '1',
    dependencies = { "nvim-tree/nvim-web-devicons" },
    opts = {
        columns = {
            'size',
            'icon',
        }
    },
}
