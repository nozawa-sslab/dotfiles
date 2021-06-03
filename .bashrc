#setopt no_beep

source ~/.zsh/aliases.sh

export TERM=xterm-256color

if type "fzf" > /dev/null 2>&1; then
	export FZF_DEFAULT_OPTS='--height 40% --layout=reverse --border'
	export FZF_CTRL_T_COMMAND='rg --files --hidden --follow --glob "!.git/*"'
	export FZF_CTRL_T_OPTS='--preview "bat  --color=always --style=header,grid --line-range :100 {}"'
fi

[ -f ~/.fzf.bash ] && source ~/.fzf.bash
#eval "$(pyenv init -)"
#eval "$(pyenv virtualenv-init -)"
