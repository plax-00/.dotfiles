" settings
source $VIMRUNTIME/defaults.vim
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
set scrolloff=12
set laststatus=2
set noshowmode
set cursorline
set encoding=utf-8
set autoread
set path+=**

autocmd BufWritePre * %s/\s\+$//e  " remove trailing whitespace on write

" ############ vim-plug section ############
call plug#begin('~/.vim/plugged')

Plug 'tomasiser/vim-code-dark'
Plug 'vim-airline/vim-airline'
Plug 'lifecrisis/vim-difforig'
Plug 'tpope/vim-commentary'

call plug#end()
" ##########################################


" plugin options
let g:airline_theme = 'codedark'
let g:airline_section_z = '%p%%  %l:%c'

colorscheme codedark
set t_Co=256
set t_ut=

" transparent bg
hi Normal guibg=NONE ctermbg=NONE
hi LineNr guibg=NONE ctermbg=NONE


" remaps
let mapleader = ' '
nnoremap <Leader>h :noh<CR>
nnoremap <Leader>' "_
nnoremap <Leader>n :bn<CR>
nnoremap <Leader>p :bp<CR>
nnoremap <Leader>i :set ignorecase!<CR>
nnoremap <Leader>I ^
nnoremap <Leader>A $
nnoremap <Leader>P "_ddP
nnoremap <Leader>b <C-^>

noremap Y y$
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l
inoremap <C-h> <Left>
inoremap <C-j> <Down>
inoremap <C-k> <Up>
inoremap <C-l> <Right>

command! -nargs=1 -complete=help H h <args> | only
