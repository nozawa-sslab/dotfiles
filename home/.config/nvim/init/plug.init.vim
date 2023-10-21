call plug#begin()

" editing
Plug 'jiangmiao/auto-pairs'
Plug 'tpope/vim-commentary'
Plug 'preservim/tagbar'
Plug 'mcchrish/nnn.vim'

" airline
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'ryanoasis/vim-devicons'

" colorscheme/highlighting
Plug 'cocopon/iceberg.vim'
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}

" completion and linting
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'godlygeek/tabular', {'for': 'md'}
Plug 'preservim/vim-markdown', {'for': 'md'}

" git
Plug 'airblade/vim-gitgutter'
Plug 'tpope/vim-fugitive'

" util
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'Shougo/vimproc.vim', {'do' : 'make'}
Plug 'lervag/vimtex', {'for': 'tex'}
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim', { 'tag': '0.1.1' }

" session
Plug 'tpope/vim-obsession'

call plug#end()
