"dein Scripts-----------------------------
" dein.vim settings {{{
" install dir {{{
"let s:dein_dir = expand('~/.config/nvim/dein')
"let s:dein_repo_dir = s:dein_dir . '/repos/github.com/Shougo/dein.vim'
" }}}

" dein installation check {{{
"if &runtimepath !~# '/dein.vim'
"  if !isdirectory(s:dein_repo_dir)
"    execute '!git clone https://github.com/Shougo/dein.vim' s:dein_repo_dir
"  endif
"  execute 'set runtimepath^=' . s:dein_repo_dir
"endif
" }}}


if &compatible
  set nocompatible               " Be iMproved
endif
set runtimepath+=~/.config/nvim/dein/repos/github.com/Shougo/dein.vim
if dein#load_state('~/.config/nvim/dein')
  call dein#begin('~/.config/nvim/dein')

  call dein#load_toml('~/.config/nvim/dein.toml', {'lazy': 0})
  call dein#load_toml('~/.config/nvim/dein_lazy.toml', {'lazy': 1})

  call dein#end()
  call dein#save_state()
endif
filetype plugin indent on
syntax enable

"Installation check-----------------------
" if dein#check_install()
" call dein#install()
" endif

"Plugin remove check {{{
let s:removed_plugins = dein#check_clean()
if len(s:removed_plugins) > 0
 call map(s:removed_plugins, "delete(v:val, 'rf')")
 call dein#recache_runtimepath()
endif
" }}}
