setopt no_beep

source ~/.zsh/aliases.sh

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
