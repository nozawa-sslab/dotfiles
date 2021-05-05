runtime init/settings.init.vim
runtime init/dein.init.vim
runtime init/defx.init.vim
runtime init/airline.init.vim
runtime init/lsp.init.vim
runtime init/easymotion.init.vim
runtime init/dbext.init.vim
runtime init/js.init.vim

let g:deoplete#enable_at_startup = 1

let g:indentLine_color_term = 239
let g:indentLine_color_gui = '#708090'
"let g:indentLine_enabled = 1
let g:indentLine_char = '│'
set list listchars=tab:\|\ 

let g:previm_open_cmd = 'open -a Google\ Chrome'
nnoremap :previm :PrevimOpen<CR>

colorscheme iceberg
"colorscheme solarized
"set background=dark

