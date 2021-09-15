source ~/.bash/aliases.sh

export TERM=xterm-256color

if type "fzf" > /dev/null 2>&1; then
	export FZF_DEFAULT_OPTS='--height 40% --layout=reverse --border'
	export FZF_CTRL_T_COMMAND='rg --files --hidden --follow --glob "!.git/*"'
	export FZF_CTRL_T_OPTS='--preview "bat  --color=always --style=header,grid --line-range :100 {}"'
fi

[ -f ~/.fzf.bash ] && source ~/.fzf.bash
#eval "$(pyenv init -)"
#eval "$(pyenv virtualenv-init -)"

export TZ=Asia/Tokyo
#export PROMPT_COMMAND="echo -n \[\$(date +%H:%M:%S)\]\ "

export PS1='\n \[\e[1;38;5;69m\]\w\[\e[0m\] \u@\h \n\[\e[38;5;4m\][\T]\[\e[0m\] \$ '

export PATH="$HOME/.yarn/bin:$HOME/.config/yarn/global/node_modules/.bin:$PATH"
