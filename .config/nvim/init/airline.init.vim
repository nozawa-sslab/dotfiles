" テーマの指定
"let g:airline_theme = 'solarized'
"let g:airline_solarized_bg='dark'
let g:airline_theme = 'luna'
"let g:airline_theme = 'wombat'

"let g:airline#extensions#tabline#left_sep = ' '
"let g:airline#extensions#tabline#left_alt_sep = '|'

let g:airline#extensions#tabline#enabled = 1 " タブラインを表示
let g:airline_powerline_fonts = 1            " Powerline Fontsを利用

let g:webdevicons_enable_airline_tabline = 0

" vim-airline : switch buffer with <C-p> and <C-n> (prev, next)
nnoremap <C-p> :bp<CR>
nnoremap <C-n> :bn<CR>

" battery
"let g:airline#extensions#battery#enabled = 1

" clock
let g:airline_section_b = '%{battery#component()} %{strftime("%H:%M")}'
