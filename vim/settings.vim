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
set foldmethod=indent
set foldcolumn=0
set foldlevelstart=99
set foldnestmax=3
set fillchars=foldsep:\ ,fold:\ ,foldopen:,foldclose:
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
    autocmd CursorHold * echon ''
augroup END



" Automatic session saving and restoring
augroup SessionManagement
    autocmd!
    autocmd VimEnter * nested call LoadSessionCWD()
    autocmd VimLeave * call SaveSessionCWD()
augroup END

if has('nvim')
    let g:sessions_directory = '~/.local/share/nvim/sessions/'
else
    let g:sessions_directory = '~/.vim/sessions/'
endif

function! CreateSessionCWD() abort
    execute 'mksession!' g:sessions_directory .. substitute(getcwd(), '/', '__', 'g')
    echo 'Session created'
endfunction

function! LoadSessionCWD() abort
    let l:session_file = expand(g:sessions_directory .. substitute(getcwd(), '/', '__', 'g'))

    if filereadable(l:session_file)
        execute 'source' l:session_file
        echo 'Session loaded'
    endif
endfunction

function! SaveSessionCWD() abort
    if filereadable(expand(g:sessions_directory .. substitute(getcwd(), '/', '__', 'g')))
        call CreateSessionCWD()
    endif
endfunction
