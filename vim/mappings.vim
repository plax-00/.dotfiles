let mapleader = ' '
nnoremap            <Leader>H       <Cmd>noh<CR>
nnoremap            <Leader>n       <Cmd>bn<CR>
nnoremap            <Leader>p       <Cmd>bp<CR>
nnoremap <expr>     <Leader>q       len(getbufinfo({'buflisted':1})) == 1 && &filetype != 'help' \|\| &filetype == 'dashboard' ? '<Cmd>q<CR>' : '<Cmd>bd<CR>'
nnoremap            <Leader>ww      <Cmd>w<CR>
nnoremap            <Leader>ws      <Cmd>w<CR><Cmd>source %<CR>
nnoremap            <Leader>x       <Cmd>x<CR>
nnoremap            <Leader>ms      <Cmd>call CreateSessionCWD()<CR>
nnoremap            <Leader>b       <C-^>
nnoremap            <Leader>d       "_d
vnoremap            <Leader>d       "_d
nnoremap            <Leader>D       "_D
nnoremap            <Leader>i       ^
vnoremap            <Leader>i       ^
nnoremap            <Leader>a       $
vnoremap            <Leader>a       $
nnoremap            <Leader>P       "_dd]P
nnoremap            <Leader>y       yyp<Cmd>call repeat#set("\<Leader>y")<CR>
nnoremap            <Leader>o       o<Esc>k<Cmd>call repeat#set("\<Leader>o",-1)<CR>
nnoremap            <Leader>;       mxA;<Esc>`x<Cmd>call repeat#set("\<Leader>;",-1)<CR>
nnoremap            <Leader>,       mxA,<Esc>`x<Cmd>call repeat#set("\<Leader>,",-1)<CR>
nnoremap            <Leader>z       za

nnoremap            Y               y$
nnoremap            G               Gzz
nnoremap            p               ]p
nnoremap            P               ]P
nnoremap            <C-h>           <C-w>h
nnoremap            <C-l>           <C-w>l
inoremap            <C-l>           <Esc>A

nmap                <C-j>           3j
nmap                <C-k>           3k
vmap                <C-j>           3j
vmap                <C-k>           3k

