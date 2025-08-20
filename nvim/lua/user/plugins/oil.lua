return {
    'stevearc/oil.nvim',
    cmd = { 'Oil' },
    keys = {
        { '<Leader>e', '<Cmd>Oil .<CR>' },
    },
    opts = {
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
}
