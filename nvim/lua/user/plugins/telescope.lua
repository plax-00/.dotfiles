local function getBackspace()
    local prompt_bufnr = vim.fn.bufnr('%')
    local actions = require('telescope.actions')
    local state = require('telescope.actions.state')
    local backspace = vim.api.nvim_replace_termcodes('<BS>', true, true, true)
    if state.get_current_line() == '' then
        actions.close(prompt_bufnr)
    else
        vim.api.nvim_feedkeys(backspace, 'n', false)
    end
end

return {
    'nvim-telescope/telescope.nvim',
    dependencies = {
        { 'nvim-telescope/telescope-fzf-native.nvim', build = 'make' },
        { 'nvim-lua/plenary.nvim' },
    },
    -- cmd = 'Telescope',
    opts = {
        defaults = {
            mappings = {
                i = {
                    ['<C-j>'] = 'move_selection_next',
                    ['<C-k>'] = 'move_selection_previous',
                    ['<Esc>'] = 'close',
                    ['<BS>'] = getBackspace,
                },
            },
            preview = false,
        },
        vimgrep_arguments = {
            'rg',
            '--color=never',
            '--no-heading',
            '--with-filename',
            '--line-number',
            '--column',
            '--smart-case',
            '--hidden',
        },
    },
    config = function(_, opts)
        require('telescope').setup(opts)
        require('telescope').load_extension('fzf')
    end,
}
