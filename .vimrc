source $VIMRUNTIME/defaults.vim
set number
set hidden
set tabstop=4
set shiftwidth=4
set background=dark
set laststatus=2
set noshowmode


" ~~~~~~~~~~~~ vim-plug section ~~~~~~~~~~~~ 
call plug#begin('~/.vim/plugged')

Plug 'joshdick/onedark.vim'
Plug 'itchyny/lightline.vim'

call plug#end()
" ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~


" plugin options
let g:onedark_hide_endofbuffer=1
let g:lightline={'colorscheme':'onedark'}

autocmd VimEnter * call SetupLightlineColors()
function SetupLightlineColors() abort
  " transparent background in statusbar
  let l:palette = lightline#palette()

  let l:palette.normal.middle = [ [ 'NONE', 'NONE', 'NONE', 'NONE' ] ]
  let l:palette.inactive.middle = l:palette.normal.middle
  let l:palette.tabline.middle = l:palette.normal.middle

  call lightline#colorscheme()
endfunction


colorscheme onedark

" transparent bg
hi Normal guibg=NONE ctermbg=NONE
