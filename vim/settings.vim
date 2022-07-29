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
set updatetime=1000
set cursorline
set mouse=a
set foldlevelstart=99
set encoding=utf-8
set autoread
set path+=**
set sessionoptions=buffers,folds,help,winsize


" :H for fullscreen help
command! -nargs=1 -complete=help H h <args> | silent! only


augroup MiscAutocmds
    autocmd!
    " Remove trailing whitespace on write
    autocmd BufWritePre * %s/\s\+$//e
    " Clear command line automatically
    autocmd CursorHold * echo ''
augroup END

