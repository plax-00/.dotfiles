" settings
source $VIMRUNTIME/defaults.vim
source ~/.vim/settings.vim


" ############ vim-plug section ############
call plug#begin('~/.vim/plugged')

Plug 'tomasiser/vim-code-dark'
Plug 'vim-airline/vim-airline'
Plug 'tpope/vim-commentary'
Plug 'jiangmiao/auto-pairs'
Plug 'jesseleite/vim-noh'
Plug 'justinmk/vim-sneak'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-repeat'
Plug 'jrudess/vim-foldtext'
Plug 'jeetsukumaran/vim-indentwise'

call plug#end()
" ##########################################


" plugin options
let g:airline_theme = 'codedark'
let g:airline_section_z = '%p%%  %l:%c'

colorscheme codedark
set t_Co=256
set t_ut=

" transparent bg
hi Normal ctermbg=NONE
hi LineNr ctermbg=NONE
hi EndOfBuffer ctermbg=NONE


" remaps
source ~/.vim/mappings.vim

