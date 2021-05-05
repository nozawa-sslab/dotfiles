if g:dein#_cache_version !=# 150 || g:dein#_init_runtimepath !=# '/Users/masa/.config/nvim,/etc/xdg/nvim,/Users/masa/.local/share/nvim/site,/usr/local/share/nvim/site,/usr/share/nvim/site,/usr/local/Cellar/neovim/0.4.4_1/share/nvim/runtime,/usr/share/nvim/site/after,/usr/local/share/nvim/site/after,/Users/masa/.local/share/nvim/site/after,/etc/xdg/nvim/after,/Users/masa/.config/nvim/after,/Users/masa/.config/nvim/dein/repos/github.com/Shougo/dein.vim' | throw 'Cache loading error' | endif
let [plugins, ftplugin] = dein#load_cache_raw(['/Users/masa/.config/nvim/init.vim', '/Users/masa/.config/nvim/dein.toml', '/Users/masa/.config/nvim/dein_lazy.toml'])
if empty(plugins) | throw 'Cache loading error' | endif
let g:dein#_plugins = plugins
let g:dein#_ftplugin = ftplugin
let g:dein#_base_path = '/Users/masa/.config/nvim/dein'
let g:dein#_runtime_path = '/Users/masa/.config/nvim/dein/.cache/init.vim/.dein'
let g:dein#_cache_path = '/Users/masa/.config/nvim/dein/.cache/init.vim'
let &runtimepath = '/Users/masa/.config/nvim,/etc/xdg/nvim,/Users/masa/.local/share/nvim/site,/usr/local/share/nvim/site,/usr/share/nvim/site,/Users/masa/.config/nvim/dein/repos/github.com/junegunn/fzf,/Users/masa/.config/nvim/dein/repos/github.com/Shougo/vimproc.vim,/Users/masa/.config/nvim/dein/repos/github.com/Shougo/dein.vim,/Users/masa/.config/nvim/dein/.cache/init.vim/.dein,/usr/local/Cellar/neovim/0.4.4_1/share/nvim/runtime,/Users/masa/.config/nvim/dein/.cache/init.vim/.dein/after,/usr/share/nvim/site/after,/usr/local/share/nvim/site/after,/Users/masa/.local/share/nvim/site/after,/etc/xdg/nvim/after,/Users/masa/.config/nvim/after'
filetype off
autocmd dein-events InsertEnter * call dein#autoload#_on_event("InsertEnter", ['deoplete.nvim', 'deoplete-vim-lsp'])
