" editing 
runtime init/settings.init.vim
"runtime init/defx.init.vim

" plugins
runtime init/plug.init.vim
"runtime init/dein.init.vim
runtime init/coc.init.vim
runtime init/git.init.vim

" airline
runtime init/airline.init.vim
"runtime init/lsp.init.vim
"runtime init/easymotion.init.vim
"runtime init/js.init.vim

"let g:deoplete#enable_at_startup = 1

"let g:indentLine_color_term = 239
"let g:indentLine_color_gui = '#708090'
"let g:indentLine_enabled = 1
"let g:indentLine_char = '│'
"set list listchars=tab:\|\ 

let g:previm_open_cmd = 'open -a Google\ Chrome'
nnoremap :previm :PrevimOpen<CR>

" JuliaFormatter
"" normal mode mapping
nnoremap <localleader>jf :JuliaFormatterFormat<CR>
" visual mode mapping
vnoremap <localleader>jf :JuliaFormatterFormat<CR>

"let g:python3_host_prog = $PYENV_ROOT . '/shims/python3'

colorscheme iceberg
"colorscheme solarized
"set background=dark

let g:latex_to_unicode_tab = "off"
