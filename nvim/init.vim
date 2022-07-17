" vim settings and mappings
source ~/.vim/settings.vim
source ~/.vim/mappings.vim

" ############ vim-plug section ############
call plug#begin('~/.config/nvim/plugged')

" base vim plugins
Plug 'tpope/vim-commentary'
Plug 'jiangmiao/auto-pairs'
Plug 'jesseleite/vim-noh'
Plug 'justinmk/vim-sneak'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-repeat'

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
Plug 'nvim-telescope/telescope-fzf-native.nvim', { 'do': 'make'  }
Plug 'nvim-telescope/telescope.nvim'
Plug 'kdheepak/lazygit.nvim'
Plug 'ThePrimeagen/harpoon'
Plug 'sindrets/diffview.nvim'
Plug 'plax-00/endscroll.nvim'

" nvim-cmp stuff
Plug 'hrsh7th/cmp-nvim-lsp'
Plug 'hrsh7th/cmp-nvim-lsp-signature-help'
Plug 'hrsh7th/cmp-path'
Plug 'hrsh7th/cmp-vsnip'
Plug 'hrsh7th/vim-vsnip'
Plug 'rafamadriz/friendly-snippets'
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

" nvim-specific mappings
source ~/.config/nvim/mappings.vim

" plugin configs
lua require('user.lsp')
lua require('user.plugins')
lua require('user.globals')

