#!/bin/sh

if type "gls" > /dev/null 2>&1; then
	alias ls='gls --color=auto'
fi

if type "nvim" > dev/null 2>&1; then
	# Neovim
	alias vi='nvim'
	alias vinit='nvim ~/.config/nvim/init.vim'
	alias vset='nvim ~/.config/nvim/init/settings.init.vim'
	alias dinit='nvim ~/.config/nvim/init/dein.init.vim'
	alias vtoml='nvim ~/.config/nvim/dein.toml'
	alias vlazy='nvim ~/.config/nvim/dein_lazy.toml'
	alias val='nvim ~/.zsh/aliases.sh'
	alias zrc='nvim ~/.zshrc'
	alias vrc='nvim ~/.vimrc'
	alias vstar='nvim ~/.config/starship.toml'
else
	alias vi='vim'
	alias zrc='vim ~/.zshrc'
	alias vrc='vim ~/.vimrc'
fi

alias ps='ps -j'
alias rel='exec $SHELL -l'
alias py='python3'
alias ctags="`brew --prefix`/bin/ctags"
alias fbat='fzf --preview "bat  --color=always --style=header,grid --line-range :100 {}"'
alias chrome='open -a "google chrome"'


# git
alias gs='git status'
