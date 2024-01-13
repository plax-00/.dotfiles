" Automatic session saving and restoring
set sessionoptions=buffers,folds,help,tabpages,winsize

augroup SessionManagement
    autocmd!
    autocmd VimEnter * ++nested call LoadSessionCWD()
    autocmd VimLeave * call SaveSessionCWD()
augroup END

let g:sessions_directory = stdpath('data') . '/sessions/'
call mkdir(g:sessions_directory, 'p')

function! GetGitBranch() abort
    return system("git branch --show-current 2> /dev/null | tr -d '\n'")
endfunction

" Called by keymap
function! CreateSessionCWD() abort
    let l:session_file = g:sessions_directory .. substitute(getcwd(), '/', '__', 'g')
    if GetGitBranch() != ''
        let l:session_file = l:session_file .. '&branch=' .. GetGitBranch()
    endif

    silent! execute 'mksession!' .. l:session_file
    echo 'Session created'
endfunction

" Called by keymap
function! DeleteSessionCWD() abort
    let l:session_file = expand(g:sessions_directory .. substitute(getcwd(), '/', '__', 'g'))
    if GetGitBranch() != ''
        let l:session_file = l:session_file .. '&branch=' .. GetGitBranch()
    endif

    if filereadable(l:session_file)
        call delete(l:session_file)
        echo 'Session deleted'
    endif
endfunction

" Called by autocmd
function! LoadSessionCWD() abort
    if $VIM_NO_SESSION_LOAD
        return
    endif

    let l:session_file = expand(g:sessions_directory .. substitute(getcwd(), '/', '__', 'g'))
    if GetGitBranch() != ''
        let l:session_file = l:session_file .. '&branch=' .. GetGitBranch()
    endif

    if filereadable(l:session_file)
        silent! execute 'source' l:session_file
        echo 'Session loaded'
    endif

    " autosave session every 30 mins
    call timer_start(1800000, 'AutosaveSession', { 'repeat': -1 })
endfunction

" Called by autocmd
function! SaveSessionCWD() abort
	if $VIM_NO_SESSION_LOAD
		return
	endif

    let l:session_file = expand(g:sessions_directory .. substitute(getcwd(), '/', '__', 'g'))
    if GetGitBranch() != ''
        let l:session_file = l:session_file .. '&branch=' .. GetGitBranch()
    endif

    if filereadable(l:session_file)
        call CreateSessionCWD()
    endif
endfunction

" Called by timer
function! AutosaveSession(timerID) abort
    call SaveSessionCWD()
    echo 'Autosaved session'
endfunction
