"let g:airline_theme = 'solarized'               " テーマの指定
"let g:airline_solarized_bg='dark'
let g:airline_theme = 'luna'
"let g:airline_theme = 'wombat'

let g:airline#extensions#tabline#left_sep = ' '
let g:airline#extensions#tabline#left_alt_sep = '|'

let g:airline#extensions#tabline#enabled = 1 " タブラインを表示
let g:airline_powerline_fonts = 1            " Powerline Fontsを利用

" vim-airline : switch buffer with <C-p> and <C-n> (prev, next)
nnoremap <C-p> :bp<CR>
nnoremap <C-n> :bn<CR>
