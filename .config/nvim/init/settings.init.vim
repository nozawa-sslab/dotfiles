" 全角文字専用の設定
"set ambiwidth=double
" Tabによるコマンド補完の候補をステータスラインに表示
set wildmenu
" backspaceを効かせる
set backspace=indent,eol,start
" <leader> == space key
let mapleader = "\<Space>"

set clipboard+=unnamedplus
"-----------------------"
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
set nu
" カーソルがある行を明示
set cursorline
" インデント
set smartindent
" 下のステータスラインを常に表示 
set laststatus=2

set noexpandtab
" インデント幅
set shiftwidth=4
" tab幅
set tabstop=4
" シンタックスハイライト
syntax enable
" hlsearch
hi Search ctermbg=34
" マウスカーソルで移動できるように
set mouse=a
" Escの2回押しでハイライト消去
nnoremap <Esc><Esc> :nohlsearch<CR>
" parentheses match
set showmatch
" 行末移動
noremap -1 $

"----------------------------------------------------------
" クリップボードからのペースト
"----------------------------------------------------------
" 挿入モードでクリップボードからペーストする時に自動でインデントさせないようにする
if &term =~ "xterm"
  let &t_SI .= "\e[?2004h"
  let &t_EI .= "\e[?2004l"
  let &pastetoggle = "\e[201~"

  function XTermPasteBegin(ret)
    set paste
    return a:ret
  endfunction

  inoremap <special> <expr> <Esc>[200~ XTermPasteBegin("")
endif

"-------------------
" undo 永続化
"-------------------
if has('persistent_undo')
	let undo_path = expand('~/.vim/undo')
	exe 'set undodir=' .. undo_path
	set undofile
endif
