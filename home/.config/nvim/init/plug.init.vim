call plug#begin()

" editing
Plug 'jiangmiao/auto-pairs'
Plug 'tpope/vim-commentary'
Plug 'preservim/tagbar'

" airline
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'ryanoasis/vim-devicons'
Plug 'cocopon/iceberg.vim'

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

call plug#end()
