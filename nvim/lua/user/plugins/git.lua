return {
    {
        'whiteinge/diffconflicts',
        cmd = 'DiffConflicts',
    },

    {
        'lewis6991/gitsigns.nvim',
        opts = {
            signs = {
                changedelete = { text = '┃' },
            },
        },
        config = function(_, opts)
            local gitsigns = require('gitsigns')
            vim.keymap.set('n', '<Leader>gl', gitsigns.toggle_linehl)
            vim.keymap.set('n', '<Leader>gt', gitsigns.preview_hunk_inline)
            vim.keymap.set('n', '<Leader>gb', gitsigns.blame)
            vim.keymap.set('n', '<Leader>gd', gitsigns.reset_hunk)
            vim.keymap.set('v', '<Leader>gd', function()
                local range_start = vim.fn.line('v')
                local range_end = vim.fn.line('.')
                gitsigns.reset_hunk({ range_start, range_end })
            end)
            vim.keymap.set('n', '<Leader>gs', gitsigns.stage_hunk)
            vim.keymap.set('v', '<Leader>gs', function()
                local range_start = vim.fn.line('v')
                local range_end = vim.fn.line('.')
                gitsigns.stage_hunk({ range_start, range_end })
            end)
            vim.keymap.set('n', ']g', function() gitsigns.nav_hunk('next') end)
            vim.keymap.set('n', '[g', function() gitsigns.nav_hunk('prev') end)

            gitsigns.setup(opts)
        end,
    },

    {
        'kdheepak/lazygit.nvim',
        cmd = 'LazyGit',
        keys = {
            { '<Leader>gg', '<Cmd>LazyGit<CR>' }
        },
    },

}
