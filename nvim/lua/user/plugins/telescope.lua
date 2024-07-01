local function get_backspace()
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
    cmd = 'Telescope',
    keys = function()
        return vim.tbl_map(function(val)
                return '<Leader>' .. val
            end,
            { 'f<Leader>', 'ff', 'fj', 'fo', 'fg', 'fk', 'fh' }
        )
    end,
    opts = {
        defaults = {
            mappings = {
                i = {
                    ['<C-j>'] = 'move_selection_next',
                    ['<C-k>'] = 'move_selection_previous',
                    ['<Esc>'] = 'close',
                    ['<BS>'] = get_backspace,
                },
            },
            preview = false,
        },
    },
    config = function(_, opts)
        local telescope = require('telescope')

        -- keymaps
        vim.cmd[[
            nnoremap    <Leader>f<Leader>     <Cmd>Telescope resume<CR>
            nnoremap    <Leader>ff            <Cmd>Telescope find_files hidden=true theme=dropdown prompt_title=Search\ Directory<CR>
            nnoremap    <Leader>fj            <Cmd>Telescope buffers theme=dropdown<CR>
            nnoremap    <Leader>fo            <Cmd>Telescope oldfiles hidden=true theme=dropdown prompt_title=Recent\ Files<CR>
            nnoremap    <Leader>fg            <Cmd>Telescope live_grep hidden=true theme=dropdown prompt_title=Grep\ Files<CR>
            nnoremap    <Leader>fk            <Cmd>Telescope keymaps hidden=true theme=dropdown<CR>
            nnoremap    <Leader>fh            <Cmd>Telescope help_tags hidden=true theme=dropdown<CR>
        ]]

        telescope.setup(opts)
        telescope.load_extension('fzf')
    end,
}
