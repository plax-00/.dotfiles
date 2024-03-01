" Nvim Tree
nnoremap    <Leader>e      <Cmd>NvimTreeToggle<CR>

" Telescope
nnoremap    <Leader>ff     <Cmd>Telescope find_files hidden=true theme=dropdown prompt_title=Search\ Directory<CR>
nnoremap    <Leader>fj     <Cmd>Telescope buffers theme=dropdown<CR>
nnoremap    <Leader>fo     <Cmd>Telescope oldfiles hidden=true theme=dropdown prompt_title=Recent\ Files<CR>
nnoremap    <Leader>fg     <Cmd>Telescope live_grep hidden=true theme=dropdown prompt_title=Grep\ Files<CR>
nnoremap    <Leader>fk     <Cmd>Telescope keymaps hidden=true theme=dropdown<CR>
nnoremap    <Leader>fh     <Cmd>Telescope help_tags hidden=true theme=dropdown<CR>

" LazyGit
nnoremap    <Leader>gg     <Cmd>LazyGit<CR>

" Noice
nnoremap    <Leader>m      <Cmd>Noice<CR>

" LSP
" nnoremap    <Leader>K      <Cmd>lua vim.lsp.buf.definition()<CR>
nnoremap    <Leader>r      <Cmd>lua vim.lsp.buf.rename()<CR>
" nnoremap    gh             <Cmd>lua vim.lsp.buf.hover()<CR>

" vim-indentwise
nmap        <Leader>]      ]=
nmap        <Leader>[      [=

" Other
nnoremap    <F2>           <Cmd>execute 'set showtabline=' . (&showtabline ==# 0 ? 2 : 0)<CR>
inoremap    <F2>           <Cmd>execute 'set showtabline=' . (&showtabline ==# 0 ? 2 : 0)<CR>
iunmap      <C-w>
