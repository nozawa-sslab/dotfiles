setopt no_beep

source ~/.zsh/aliases.sh

autoload -Uz compinit && compinit

export TERM=xterm-256color
export JULIA_DIR="/Applications/Julia-1.6.app/Contents/Resources/Julia"
export PATH="$JULIA_DIR/bin:$PATH"
export PATH="$PATH:$HOME/.cargo/bin"
export PATH="/home/nozawa/.local/bin:$PATH"

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

FPATH=~/.zsh/plug/zsh-completions:$FPATH

source ~/.zsh/plug/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
source ~/.zsh/plug/zsh-autosuggestions/zsh-autosuggestions.zsh

eval "$(zoxide init zsh)"
eval "$(starship init zsh)"

# Generated for envman. Do not edit.
[ -s "$HOME/.config/envman/load.sh" ] && source "$HOME/.config/envman/load.sh"

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
