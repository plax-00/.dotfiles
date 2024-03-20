return {
    'hachy/cmdpalette.nvim',
    opts = {},
    init = function()
        vim.cmd [[
            nnoremap q: <Plug>(cmdpalette)
        ]]
    end,
}
