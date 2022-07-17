let mapleader = ' '
nnoremap <silent>           <Leader>H   :noh<CR>
nnoremap <silent>           <Leader>n   :bn<CR>
nnoremap <silent>           <Leader>p   :bp<CR>
nnoremap <silent><expr>     <Leader>q   len(getbufinfo({'buflisted':1}))==1 ? ':q<CR>' : ':bd<CR>'
nnoremap <silent>           <Leader>ww  :w<CR>
nnoremap <silent>           <Leader>ws  :w<CR>:source %<CR>
nnoremap <silent>           <Leader>x   :x<CR>
nnoremap                    <Leader>d   "_d
nnoremap                    <Leader>D   "_D
nnoremap                    <Leader>i   ^
nnoremap                    <Leader>a   $
nnoremap                    <Leader>P   "_dd]P
nnoremap                    <Leader>y   yyp
nnoremap                    <Leader>b   <C-^>
nnoremap                    <Leader>o   o<Esc>k

nnoremap                    Y           y$
nnoremap                    G           Gzz

nnoremap                    p           ]p
nnoremap                    P           ]P
nnoremap                    <C-h>       <C-w>h
nnoremap                    <C-l>       <C-w>l
inoremap                    <C-l>       <Esc>A

nmap                        <C-j>       3j
nmap                        <C-k>       3k
vmap                        <C-j>       3j
vmap                        <C-k>       3k

