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
    silent! execute 'mksession!' g:sessions_directory .. substitute(getcwd(), '/', '__', 'g')
    echo 'Session created'
endfunction

function! LoadSessionCWD() abort
    let l:session_file = expand(g:sessions_directory .. substitute(getcwd(), '/', '__', 'g'))

    if filereadable(l:session_file)
        silent! execute 'source' l:session_file
        echo 'Session loaded'
    endif
endfunction

function! SaveSessionCWD() abort
    if filereadable(expand(g:sessions_directory .. substitute(getcwd(), '/', '__', 'g')))
        call CreateSessionCWD()
    endif
endfunction

