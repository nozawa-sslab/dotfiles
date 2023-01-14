" 全角文字専用の設定
"set ambiwidth=double
" Tabによるコマンド補完の候補をステータスラインに表示
set wildmenu
" backspaceを効かせる
set backspace=indent,eol,start
" <leader> == space key
let mapleader = "\<Space>"

set clipboard+=unnamedplus
" remap Esc
:imap jj <Esc>
" remap :w
:noremap ff :w<CR>

" Use ctrl-[hjkl] to select the active split!
nmap <silent> <c-k> :wincmd k<CR>
nmap <silent> <c-j> :wincmd j<CR>
nmap <silent> <c-h> :wincmd h<CR>
nmap <silent> <c-l> :wincmd l<CR>

" Quickly insert an empty new line without entering insert mode
nnoremap <Leader>o o<Esc>
nnoremap <Leader>O O<Esc>
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
set t_Co=256
" Enable 24-bit RGB color
set termguicolors
" Background Opa
au ColorScheme * highlight Normal ctermbg=none guibg=none
au ColorScheme iceberg highlight NonText ctermbg=none guibg=none
au ColorScheme iceberg highlight LineNr ctermbg=none guibg=none
hi CursorLineNr cterm=NONE ctermbg=237 ctermfg=253 guibg=#2a3158 guifg=#cdd1e6
" language
language en_US.UTF-8
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

set expandtab
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

set noswapfile

augroup fileTypeIndent
    autocmd!
    autocmd BufNewFile,BufRead *.py setlocal tabstop=4 softtabstop=4 shiftwidth=4
    autocmd BufNewFile,BufRead *.jl setlocal tabstop=4 softtabstop=4 shiftwidth=4
    autocmd BufNewFile,BufRead *.sv setlocal tabstop=2 softtabstop=2 shiftwidth=2
    autocmd BufNewFile,BufRead *.rb setlocal tabstop=2 softtabstop=2 shiftwidth=2
    autocmd BufNewFile,BufRead *.c setlocal tabstop=2 softtabstop=2 shiftwidth=2
    autocmd BufNewFile,BufRead *.cc setlocal tabstop=2 softtabstop=2 shiftwidth=2
    autocmd BufNewFile,BufRead *.cpp setlocal tabstop=2 softtabstop=2 shiftwidth=2
    autocmd BufNewFile,BufRead *.h setlocal tabstop=2 softtabstop=2 shiftwidth=2
    autocmd BufNewFile,BufRead *.hh setlocal tabstop=2 softtabstop=2 shiftwidth=2
    autocmd BufNewFile,BufRead *.html setlocal tabstop=2 softtabstop=2 shiftwidth=2
    autocmd BufNewFile,BufRead *.j2 setlocal tabstop=2 softtabstop=2 shiftwidth=2
    autocmd BufNewFile,BufRead *.erb setlocal tabstop=2 softtabstop=2 shiftwidth=2
    autocmd BufNewFile,BufRead *.hs setlocal tabstop=2 softtabstop=2 shiftwidth=2
    autocmd BufNewFile,BufRead *.dart setlocal tabstop=2 softtabstop=2 shiftwidth=2
    autocmd BufNewFile,BufRead *.json setlocal tabstop=2 softtabstop=2 shiftwidth=2
    autocmd BufNewFile,BufRead *.rs setlocal tabstop=4 softtabstop=4 shiftwidth=4
augroup END

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


"-------------------
" cd to the directory of opening file for the current window
"-------------------
noremap <leader>cd :cd %:p:h<CR>:pwd<CR>
