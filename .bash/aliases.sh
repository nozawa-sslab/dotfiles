#!/bin/sh
alias ls='ls --color=auto'
alias ll='ls -al' 

if type "gls" > /dev/null 2>&1; then
	alias ls='gls --color=auto'
	alias ll='gls -l --color=auto'
fi

alias val='nvim ~/.bash/aliases.sh'
alias ps='ps -j'
alias brc='nvim ~/.bashrc'
alias vrc='nvim ~/.vimrc'
alias rel='exec $SHELL -l'
alias gcc='/usr/local/bin/gcc-11'
alias g++='/usr/local/bin/g++-11'

# Neovim
alias vi='nvim'
alias vinit='nvim ~/.config/nvim/init.vim'
alias vset='nvim ~/.config/nvim/init/settings.init.vim'
alias dinit='nvim ~/.config/nvim/init/dein.init.vim'
alias vtoml='nvim ~/.config/nvim/dein.toml'
alias vlazy='nvim ~/.config/nvim/dein_lazy.toml'

# git
alias gs='git status'
