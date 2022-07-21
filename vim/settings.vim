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
set mouse=a
set foldmethod=syntax
set foldlevelstart=99
set encoding=utf-8
set autoread
set path+=**
set sessionoptions=buffers,folds,winsize


autocmd BufWritePre * %s/\s\+$//e  " remove trailing whitespace on write
autocmd CursorHold * echon ''
command! -nargs=1 -complete=help H h <args> | only


" Automatic session saving and restoring
autocmd VimEnter * nested call LoadSessionCWD()
autocmd VimLeave * call SaveSessionCWD()

if has('nvim')
    let g:sessions_directory = '~/.local/share/nvim/sessions/'
else
    let g:sessions_directory = '~/.vim/sessions/'
endif

function! CreateSessionCWD()
    execute 'mksession!' g:sessions_directory .. substitute(getcwd(), '/', '__', 'g')
    echo 'Session created'
endfunction

function! LoadSessionCWD()
    let l:session_file = expand(g:sessions_directory .. substitute(getcwd(), '/', '__', 'g'))

    if filereadable(l:session_file)
        execute 'source' l:session_file
        echo 'Session loaded'
    endif
endfunction

function! SaveSessionCWD()
    if filereadable(expand(g:sessions_directory .. substitute(getcwd(), '/', '__', 'g')))
        call CreateSessionCWD()
    endif
endfunction
