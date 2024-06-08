return {
    {
        'whiteinge/diffconflicts'
    },

    {
        'lewis6991/gitsigns.nvim',
        opts = {
            signs = {
                changedelete = { hl = 'GitSignsChange', text = '┃', numhl='GitSignsChangeNr', linehl='GitSignsChangeLn' },
            },
        },
        config = function(_, opts)
            local gitsigns = require('gitsigns')
            vim.keymap.set('n', '<Leader>gl', gitsigns.toggle_linehl)
            vim.keymap.set('n', '<Leader>gt', gitsigns.toggle_deleted)
            vim.keymap.set('n', '<Leader>gd', gitsigns.reset_hunk)
            vim.keymap.set('v', '<Leader>gd', function()
                local range_start = vim.fn.line('v')
                local range_end = vim.fn.line('.')
                gitsigns.reset_hunk({ range_start, range_end })
            end)
            vim.keymap.set('v', '<Leader>gs', function()
                local range_start = vim.fn.line('v')
                local range_end = vim.fn.line('.')
                gitsigns.stage_hunk({ range_start, range_end })
            end)

            gitsigns.setup(opts)
        end,
    },

    {
        'kdheepak/lazygit.nvim',
        dependencies = { 'nvim-lua/plenary.nvim' },
        cmd = 'LazyGit',
    },

}
