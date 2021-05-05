" 全角文字専用の設定
set ambiwidth=double
" Tabによるコマンド補完の候補をステータスラインに表示
set wildmenu
" backspaceを効かせる
set backspace=indent,eol,start
"-----------------------
" 検索
"-----------------------
" 大文字小文字の区別なし
set ignorecase
" 検索結果ハイライト
set hlsearch

"-----------------------
" 表示設定
"-----------------------
" 音消す
set noerrorbells
set vb t_vb=
" 相対行番号
set relativenumber
" カーソルがある行を明示
set cursorline
" インデント
set smartindent
" 下のステータスラインを常に表示 
set laststatus=2
" インデント幅
set shiftwidth=4
" tab幅
set tabstop=4
" シンタックスハイライト
syntax enable

hi Search ctermbg=34
" マウスカーソルで移動できるように
set mouse=a
" Escの2回押しでハイライト消去
nnoremap <Esc><Esc> :nohlsearch<CR><Esc>
" parentheses match
set showmatch
