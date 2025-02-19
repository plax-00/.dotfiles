" Automatic session saving and restoring
set sessionoptions=buffers,folds,help,tabpages,winsize

augroup SessionManagement
    autocmd!
    autocmd VimEnter * ++nested call LoadSessionCWD()
    autocmd VimLeave * call SaveSessionCWD()
augroup END

let g:sessions_directory = stdpath('data') . '/sessions/'
call mkdir(g:sessions_directory, 'p')

function! GetSessionList() abort
    call system('rmdir --ignore-fail-on-non-empty ' .. g:sessions_directory .. '/*')
    return map(readdir(g:sessions_directory), 'substitute(v:val, "__", "/", "g")')
endfunction

function! s:GetSessionFile() abort
    let l:branch = system("git branch --show-current 2> /dev/null | tr -d '\n'")
    let l:session_subdir = g:sessions_directory .. substitute(getcwd(), '/', '__', 'g')
    call mkdir(l:session_subdir, 'p')
    if l:branch == ''
        let l:session_file = l:session_subdir .. '/__norepo__'
    else
        let l:session_file = l:session_subdir .. '/' .. l:branch
    endif

    return l:session_file
endfunction

" Called by keymap
function! CreateSessionCWD() abort
    let l:session_file = s:GetSessionFile()
    silent! execute 'mksession!' .. l:session_file
    echo 'Session created'
endfunction

" Called by keymap
function! DeleteSessionCWD() abort
    let l:session_file = s:GetSessionFile()

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

    let l:session_file = s:GetSessionFile()

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

    let l:session_file = s:GetSessionFile()

    if filereadable(l:session_file)
        call CreateSessionCWD()
    endif
endfunction

" Called by timer
function! AutosaveSession(timerID) abort
    call SaveSessionCWD()
    echo 'Autosaved session'
endfunction
