source ~/.vim/settings.vim
source ~/.vim/mappings.vim

" ############ vim-plug section ############
call plug#begin('~/.config/nvim/plugged')

" base vim plugins
Plug 'lifecrisis/vim-difforig'
Plug 'tpope/vim-commentary'
Plug 'jiangmiao/auto-pairs'
Plug 'jesseleite/vim-noh'
Plug 'justinmk/vim-sneak'
Plug 'tpope/vim-surround'

" nvim plugins
Plug 'Mofiqul/vscode.nvim'
Plug 'williamboman/nvim-lsp-installer'
Plug 'neovim/nvim-lspconfig'
Plug 'nvim-treesitter/nvim-treesitter', { 'do': ':TSUpdate' }
Plug 'p00f/nvim-ts-rainbow'
Plug 'kyazdani42/nvim-web-devicons'
Plug 'kyazdani42/nvim-tree.lua'
Plug 'lukas-reineke/indent-blankline.nvim'
Plug 'lewis6991/gitsigns.nvim'
Plug 'akinsho/bufferline.nvim', { 'tag': 'v2.*' }
Plug 'nvim-lualine/lualine.nvim'
Plug 'glepnir/dashboard-nvim'
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim'
Plug 'kdheepak/lazygit.nvim'

" nvim-cmp stuff
Plug 'hrsh7th/cmp-nvim-lsp'
Plug 'hrsh7th/cmp-nvim-lsp-signature-help'
Plug 'hrsh7th/cmp-path'
Plug 'hrsh7th/cmp-vsnip'
Plug 'hrsh7th/vim-vsnip'
Plug 'hrsh7th/nvim-cmp'

call plug#end()
" ##########################################


let g:vscode_transparency = 1
let g:vscode_disable_nvimtree_bg = v:true
colorscheme vscode


" transparent bg
hi Normal ctermbg=NONE
hi LineNr ctermbg=NONE
hi EndOfBuffer ctermbg=NONE

" extension mappings
nnoremap <silent> <Leader>e :NvimTreeToggle<CR>
nnoremap <silent> <Leader>ff :Telescope find_files hidden=true<CR>
nnoremap <silent> <Leader>fo :Telescope oldfiles<CR>
nnoremap <silent> <Leader>tt :execute 'set showtabline=' . (&showtabline ==# 0 ? 2 : 0)<CR>
nnoremap <silent> <Leader>tl :setlocal invbuflisted<CR>
nnoremap <silent> <Leader>K :lua vim.lsp.buf.definition()<CR>
nnoremap <silent> <Leader>r :lua vim.lsp.buf.rename()<CR>
nnoremap <silent> gh :lua vim.lsp.buf.hover()<CR>

" plugin configs
lua require("user.lsp.config")
lua require("user.plugins.init")

