vim.treesitter.start()
vim.cmd([[
    silent! wincmd L
    vertical resize 100
    nnoremap <buffer> o <Cmd>only<CR>
    nnoremap <buffer> > <Cmd>vertical resize -2<CR>
    nnoremap <buffer> < <Cmd>vertical resize +2<CR>
]])
