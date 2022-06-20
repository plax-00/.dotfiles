" settings
source $VIMRUNTIME/defaults.vim
set number
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

autocmd BufWritePre * %s/\s\+$//e  " remove trailing whitespace

" ############ vim-plug section ############
call plug#begin('~/.vim/plugged')

Plug 'tomasiser/vim-code-dark'
Plug 'vim-airline/vim-airline'
Plug 'lifecrisis/vim-difforig'

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
nnoremap <leader>h :noh<CR>
nnoremap <leader>' "_
nnoremap <leader>n :bn<CR>
nnoremap <leader>p :bp<CR>
nnoremap <leader>i :set ignorecase!<CR>
nnoremap <leader>I ^
nnoremap <leader>A $
nnoremap <leader>P "_ddP

noremap Y y$
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l

