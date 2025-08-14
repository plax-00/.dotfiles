let mapleader = ' '

nmap                <Leader>n            <Cmd>bn<CR><Leader>\buffer
nmap                <Leader>N            <Cmd>bp<CR><Leader>\buffer
nmap                <Leader>\buffern     <Leader>n
nmap                <Leader>\bufferN     <Leader>N
nmap                <Leader>t            <Cmd>tabn<CR><Leader>\tabpage
nmap                <Leader>T            <Cmd>tabp<CR><Leader>\tabpage
nmap                <Leader>\tabpaget    <Leader>t
nmap                <Leader>\tabpageT    <Leader>T
nnoremap            <Leader><BS>         <Cmd>call <SID>PrevTab()<CR>

nnoremap            <Leader>h            <Cmd>noh<CR>
nnoremap            <Leader>q            <Cmd>call <SID>LeaderQ()<CR>
nnoremap            <Leader>ww           <Cmd>update<CR>
nnoremap            <Leader>ws           <Cmd>update<CR><Cmd>source %<CR>
nnoremap            <Leader>x            <Cmd>update<CR><Cmd>qall<CR>
nnoremap            <Leader>b            <C-^>
nnoremap            <Leader>d            "_d
vnoremap            <Leader>d            "_d
nnoremap            <Leader>D            "_D
nnoremap            <Leader>i            ^
vnoremap            <Leader>i            ^
nnoremap            <Leader>a            $
vnoremap            <Leader>a            $
nnoremap            <Leader>p            "_dd<Cmd>call <SID>SmartPut('P')<CR>
nnoremap            <Leader>y            yyp<Cmd>call repeat#set("\<Leader>y")<CR>
nnoremap            <Leader>o            o<Esc>k<Cmd>call repeat#set("\<Leader>o",-1)<CR>
nnoremap            <Leader>;            mxA;<Esc>`x<Cmd>call repeat#set("\<Leader>;",-1)<CR>
nnoremap            <Leader>,            mxA,<Esc>`x<Cmd>call repeat#set("\<Leader>,",-1)<CR>
nnoremap            <Leader>z            za
nnoremap            <Leader>:            q:

nnoremap            Y                    y$
nnoremap            G                    Gzz
nnoremap            p                    <Cmd>call <SID>SmartPut('p')<CR>
nnoremap            P                    <Cmd>call <SID>SmartPut('P')<CR>
nnoremap <expr>     i                    trim(getline('.')) == '' ? 'cc' : 'i'
nnoremap            <C-h>                <C-w>h
nnoremap            <C-l>                <C-w>l
inoremap            <C-l>                <Esc>A
onoremap <expr>     <Leader>             '<Esc>' .. '"' .. nr2char(getchar()) .. v:operator
tnoremap            <C-\>                <C-\><C-n>

nmap                <C-j>                <C-d>
nmap                <C-k>                <C-u>
vnoremap            <C-j>                3j
vnoremap            <C-k>                3k

silent! iunmap      <C-w>

function! s:LeaderQ() abort
    let l:filetypes = ['dashboard', 'lazy', 'oil', 'help']  " filetypes to quit out for

    let l:quitOut = v:false
    let l:bufCount = len(getbufinfo({ 'buflisted': 1 }))

    if (winlayout()[0] != 'leaf' || tabpagenr() > 1)  " if there are multiple windows or tabs just close
        close
        return
    endif

    if (win_gettype() == 'popup') " close floating win
        close
        return
    endif

    if (l:bufCount > 1 && tabpagenr() == 1)  " avoid closing tabpage in tab 1
        buffer #
        bdelete #
        return
    endif

    if (l:bufCount == 1 && &filetype != 'help')  " check if there is only 1 buffer
        let l:quitOut = v:true
    endif

    if (&buftype == 'nofile' && &filetype == 'vim')  " check for cmdwin
        let l:quitOut = v:true
    endif

    for f in l:filetypes  " check for filetypes
        if &filetype == f
            let l:quitOut = v:true
        endif
    endfor

    if l:quitOut
        quit
    else
        bdelete
    endif
endfunction

function! s:SmartPut(p_or_P) abort
    let l:regtype = getregtype()
    execute 'normal!' '"' .. v:register .. a:p_or_P
    if l:regtype ==# 'V'
        normal! '[mx
        '[,']normal! ==
        normal! 'x
    endif
endfunction

function! s:PrevTab() abort
    let l:tab = tabpagenr('#')
    if l:tab == 0
        let l:tab = 1
    endif

    execute 'normal!' l:tab .. 'gt'
endfunction
