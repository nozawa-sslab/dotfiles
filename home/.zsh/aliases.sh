#!/bin/sh
if type "gls" > /dev/null 2>&1; then
	alias ls='gls --color=auto'
	alias ll='gls -l --color=auto'
	alias la='gls -a --color=auto'
else
	alias ls='ls --color=auto'
	alias ll='ls -l --color=auto'
	alias la='ls -a --color=auto'
fi

alias val='nvim ~/.zsh/aliases.sh'
alias ps='ps -j'
alias zrc='nvim ~/.zshrc'
alias vrc='nvim ~/.vimrc'
alias rel='exec $SHELL -l'
alias fbat='fzf --preview "bat  --color=always --style=header,grid --line-range :100 {}"'
alias vstar='nvim ~/.config/starship.toml'
alias chrome='open -a "google chrome"'
alias clip='(){cat $1 | pbcopy}'

# Neovim
alias vi='nvim'
alias vinit='nvim ~/.config/nvim/init.vim'
alias vset='nvim ~/.config/nvim/init/settings.init.vim'
alias dinit='nvim ~/.config/nvim/init/dein.init.vim'
alias vtoml='nvim ~/.config/nvim/dein.toml'
alias vlazy='nvim ~/.config/nvim/dein_lazy.toml'

# git
alias gs='git status'
