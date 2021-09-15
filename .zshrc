setopt no_beep

source ~/.zsh/aliases.sh

autoload -Uz compinit && compinit

export TERM=xterm-256color
export JULIA_DIR="/Applications/Julia-1.6.app/Contents/Resources/Julia"
export PATH="$JULIA_DIR/bin:$PATH"

export CPATH="/usr/local/lib/python3.9/site-packages/numpy/core/include:/usr/local/opt/python@3.9/Frameworks/Python.framework/Versions/3.9/include/python3.9"

#export EDITOR="nvim"
bindkey \^U backward-kill-line


if type "fzf" > /dev/null 2>&1; then
	export FZF_DEFAULT_OPTS='--height 40% --layout=reverse --border'
	export FZF_CTRL_T_COMMAND='rg --files --hidden --follow --glob "!.git/*"'
	export FZF_CTRL_T_OPTS='--preview "bat  --color=always --style=header,grid --line-range :100 {}"'
fi

typeset -A ZSH_HIGHLIGHT_STYLES
ZSH_HIGHLIGHT_STYLES[path]=underline

if type brew &>/dev/null; then
    FPATH=$(brew --prefix)/share/zsh-completions:$FPATH

    autoload -Uz compinit
    compinit
fi

if test -d ~/.zsh/plug/zsh-syntax-highlighting; then
	source ~/.zsh/plug/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
else
	git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ~/.zsh/plug/zsh-syntax-highlighting
	source ~/.zsh/plug/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
fi

if test -d ~/.zsh/plug/zsh-autosuggestions; then
	source ~/.zsh/plug/zsh-autosuggestions/zsh-autosuggestions.zsh
else
	git clone https://github.com/zsh-users/zsh-autosuggestions ~/.zsh/plug/zsh-autosuggestions
	source ~/.zsh/plug/zsh-autosuggestions/zsh-autosuggestions.zsh
fi

eval "$(zoxide init zsh)"
eval "$(starship init zsh)"
