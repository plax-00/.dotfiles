return {
    'stevearc/oil.nvim',
    event = 'VeryLazy',
    cmd = { 'Oil' },
    keys = {
        { '<Leader>e', '<Cmd>Oil .<CR>' },
    },
    opts = {
        default_file_explorer = true,
        columns = {
            'size',
            'icon',
        },
        keymaps = {
            ['H'] = { 'actions.parent', mode = 'n' },
            ['L'] = { 'actions.select', mode = 'n' },
            ['<Leader>e'] = { 'actions.close', mode = 'n' }
        }
    },
    init = function ()
        vim.g.loaded_netrw = 1
        vim.g.loaded_netrwPlugin = 1
    end,
}
