let mapleader = ' '

nmap                <Leader>n            <Cmd>bn<CR><Leader>\buffer
nmap                <Leader>N            <Cmd>bp<CR><Leader>\buffer
nmap                <Leader>\buffern     <Leader>n
nmap                <Leader>\bufferN     <Leader>N
nmap                <Leader>t            <Cmd>tabn<CR><Leader>\tabpage
nmap                <Leader>T            <Cmd>tabp<CR><Leader>\tabpage
nmap                <Leader>\tabpaget    <Leader>t
nmap                <Leader>\tabpageT    <Leader>T
nnoremap            <Leader><BS>         g<Tab>

nnoremap            <Leader>h            <Cmd>noh<CR>
nnoremap            <Leader>q            <Cmd>call LeaderQ()<CR>
nnoremap            <Leader>ww           <Cmd>update<CR>
nnoremap            <Leader>ws           <Cmd>update<CR><Cmd>source %<CR>
nnoremap            <Leader>x            <Cmd>update<CR><Cmd>qall<CR>
nnoremap            <Leader>sm           <Cmd>call CreateSessionCWD()<CR>
nnoremap            <Leader>sd           <Cmd>call DeleteSessionCWD()<CR>
nnoremap            <Leader>b            <C-^>
nnoremap            <Leader>d            "_d
vnoremap            <Leader>d            "_d
nnoremap            <Leader>D            "_D
nnoremap            <Leader>i            ^
vnoremap            <Leader>i            ^
nnoremap            <Leader>a            $
vnoremap            <Leader>a            $
nnoremap            <Leader>P            "_dd]P
nnoremap            <Leader>y            yyp<Cmd>call repeat#set("\<Leader>y")<CR>
nnoremap            <Leader>o            o<Esc>k<Cmd>call repeat#set("\<Leader>o",-1)<CR>
nnoremap            <Leader>;            mxA;<Esc>`x<Cmd>call repeat#set("\<Leader>;",-1)<CR>
nnoremap            <Leader>,            mxA,<Esc>`x<Cmd>call repeat#set("\<Leader>,",-1)<CR>
nnoremap            <Leader>z            za
nnoremap            <Leader>:            q:

nnoremap            Y                    y$
nnoremap            G                    Gzz
nnoremap            p                    ]p
nnoremap            P                    ]P
nnoremap <expr>     i                    trim(getline('.')) == '' ? 'cc' : 'i'
nnoremap            <C-h>                <C-w>h
nnoremap            <C-l>                <C-w>l
inoremap            <C-l>                <Esc>A

nmap                <C-j>                3j
nmap                <C-k>                3k
vmap                <C-j>                3j
vmap                <C-k>                3k
imap                jj                   <Esc>


function! LeaderQ() abort
    let l:quitOut = v:false
    let l:bufCount = len(getbufinfo({ 'buflisted': 1 }))

    if (l:bufCount > 1 && tabpagenr() == 1)  " avoid closing tabpage in tab 1
        bnext
        bdelete #
        return
    endif

    if (l:bufCount == 1 && &filetype != 'help')  " check if there is only 1 buffer
        let l:quitOut = v:true
        if (tabpagenr() == 1)
            let l:mainTabpage = v:true
        endif
    endif

    if (&buftype == 'nofile' && &filetype == 'vim')  " check for cmdwin
        let l:quitOut = v:true
    endif

    if &filetype == 'dashboard' || &filetype == 'lazy'  " check for filetypes
        let l:quitOut = v:true
    endif

    if l:quitOut
        quit
    else
        bdelete
    endif
endfunction
