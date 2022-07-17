set number relativenumber
set hidden
set tabstop=4 softtabstop=4
set shiftwidth=4
set expandtab
set nowrap
set hlsearch
set incsearch
set ignorecase
set smartcase
set notimeout
set scrolloff=12 sidescrolloff=10
set laststatus=2
set noshowmode
set cursorline
set foldmethod=syntax
set foldlevelstart=99
set encoding=utf-8
set autoread
set path+=**

autocmd BufWritePre * %s/\s\+$//e  " remove trailing whitespace on write
autocmd CursorHold * echon ''
command! -nargs=1 -complete=help H h <args> | only | set buflisted
