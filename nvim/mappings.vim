" Nvim Tree
nnoremap <silent> <Leader>e :NvimTreeToggle<CR>

" Telescope
nnoremap <silent> <Leader>ff :Telescope find_files hidden=true theme=dropdown prompt_title=Search\ Directory<CR>
nnoremap <silent> <Leader>fj :Telescope buffers theme=dropdown<CR>
nnoremap <silent> <Leader>fo :Telescope oldfiles hidden=true theme=dropdown prompt_title=Recent\ Files<CR>
nnoremap <silent> <Leader>fg :Telescope live_grep hidden=true theme=dropdown prompt_title=Grep\ Files<CR>

" LazyGit
nnoremap <silent> <Leader>gg :LazyGit<CR>

" LSP
nnoremap <silent> <Leader>K :lua vim.lsp.buf.definition()<CR>
nnoremap <silent> <Leader>r :lua vim.lsp.buf.rename()<CR>
nnoremap <silent> gh :lua vim.lsp.buf.hover()<CR>

" vim-indentwise
nmap <silent> <Leader>] ]=
nmap <silent> <Leader>[ [=

" Other
nnoremap <silent> <Leader>tt :execute 'set showtabline=' . (&showtabline ==# 0 ? 2 : 0)<CR>
silent! iunmap <C-w>

