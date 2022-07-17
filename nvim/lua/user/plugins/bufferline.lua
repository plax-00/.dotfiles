require('bufferline').setup {
    options = {
        numbers = 'buffer_id',
        show_buffer_close_icons = false,
        show_close_icon = false,
        diagnostics = 'nvim_lsp',
        offsets = {
            { filetype = 'NvimTree', text = 'File Explorer', highlight = 'Directory' },
        },
    }
}

vim.o.showtabline = 0

