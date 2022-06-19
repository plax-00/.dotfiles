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
set notimeout
set scrolloff=10
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


" remaps
let mapleader = ' '
nnoremap <leader>h :noh<CR>
nnoremap <leader>' "_
