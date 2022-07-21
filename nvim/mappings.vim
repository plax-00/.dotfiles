" Nvim Tree
nnoremap <silent> <Leader>e :NvimTreeToggle<CR>

" Telescope
nnoremap <silent> <Leader>ff :Telescope find_files hidden=true theme=dropdown prompt_title=Search\ Directory<CR>
nnoremap <silent> <Leader>fj :Telescope buffers theme=dropdown<CR>
nnoremap <silent> <Leader>fo :Telescope oldfiles hidden=true theme=dropdown prompt_title=Recent\ Files<CR>
nnoremap <silent> <Leader>fg :Telescope live_grep hidden=true theme=dropdown prompt_title=Grep\ Files<CR>

" Harpoon
nnoremap <silent> <Leader>ha :lua require('harpoon.mark').add_file()<CR>
nnoremap <silent> <Leader>hm :lua require('harpoon.ui').toggle_quick_menu()<CR>
nnoremap <silent> <Leader>hh :lua require('harpoon.ui').nav_file(1)<CR>
nnoremap <silent> <Leader>hj :lua require('harpoon.ui').nav_file(2)<CR>
nnoremap <silent> <Leader>hk :lua require('harpoon.ui').nav_file(3)<CR>
nnoremap <silent> <Leader>hl :lua require('harpoon.ui').nav_file(4)<CR>

" LazyGit
nnoremap <silent> <Leader>gg :LazyGit<CR>

" LSP
nnoremap <silent> <Leader>K :lua vim.lsp.buf.definition()<CR>
nnoremap <silent> <Leader>r :lua vim.lsp.buf.rename()<CR>
nnoremap <silent> gh :lua vim.lsp.buf.hover()<CR>

" Other
nnoremap <silent> <Leader>tt :execute 'set showtabline=' . (&showtabline ==# 0 ? 2 : 0)<CR>
silent! iunmap <C-w>

