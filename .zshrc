setopt no_beep

# alias
source ~/.zsh/aliases.sh

source ~/research/serialize/mymethod/setup.sh

autoload -Uz compinit && compinit

export TZ=Asia/Tokyo
export TERM=xterm-256color

export HISTFILE="$HOME/.zsh_history"
export HISTSIZE=2000
export SAVEHIST=1000

export JULIA_DIR="$HOME/julia-1.6.2"
export PATH="$JULIA_DIR/bin:$PATH"
export PATH="$HOME/.cargo/bin:$PATH"
export PATH="$HOME/.local/bin:$PATH"
export PATH="$HOME/oss/bin:$PATH"
export PATH="$HOME/node_modules/:$PATH"
export PATH="$HOME/.npm_global/bin:$PATH"

export PROPOSAL_DIR="$HOME/research/serialize/mymethod"

export PYTHONPATH="/home/nozawa/.pyenv/versions/3.9.7/lib/python3.9/site-packages/"
export PYTHONPATH="/home/nozawa/research/mymmap/"

# for backward-kill-word
export WORDCHARS=${WORDCHARS/\/}

export SLACK_INCOMING_WEBHOOK_URL="https://hooks.slack.com/services/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"

# clang's {include, library} path
export CPATH="/home/nozawa/.pyenv/versions/3.9.7/include/python3.9/:/home/nozawa/.pyenv/versions/3.9.7/lib/python3.9/site-packages/numpy/core/include:/usr/local/lib/python3.9/site-packages/numpy/core/include:/usr/local/opt/python@3.9/Frameworks/Python.framework/Versions/3.9/include/python3.9"
export CPATH="/home/nozawa/.local/include:$CPATH"
export CPATH="/home/nozawa/research/mymmap:$CPATH"
export LD_LIBRARY_PATH="/home/nozawa/.local/lib:$LIBRARY_PATH"

export EDITOR="nvim"
bindkey \^U backward-kill-line
bindkey "^[f" forward-word
bindkey "^[b" backward-word
bindkey "^A" beginning-of-line
bindkey "^E" end-of-line
bindkey '^ ' autosuggest-accept

#########
#  FZF  #
#########

if type "fzf" > /dev/null 2>&1; then
	export FZF_DEFAULT_OPTS='--height 40% --layout=reverse --border'
	export FZF_DEFAULT_COMMAND='rg --files --hidden --follow --glob "!.git/*"'
	export FZF_CTRL_T_COMMAND='rg --files --hidden --follow --glob "!.git/*"'
	export FZF_CTRL_T_OPTS='--preview "bat --color=always --style=header,grid --line-range :100 {}"'
fi

alias glNoGraph='git log --color=always --format="%C(auto)%h%d %s %C(black)%C(bold)%cr% C(auto)%an" "$@"'
_gitLogLineToHash="echo {} | grep -o '[a-f0-9]\{7\}' | head -1"
_viewGitLogLine="$_gitLogLineToHash | xargs -I % sh -c 'git show --color=always % | diff-so-fancy'"


# fshow - git commit browser
fshow() {
  git log --graph --color=always \
      --format="%C(auto)%h%d %s %C(black)%C(bold)%cr" "$@" |
  fzf --ansi --no-sort --reverse --tiebreak=index --bind=ctrl-s:toggle-sort --preview="$_viewGitLogLine" \
      --bind "ctrl-m:execute:
                (grep -o '[a-f0-9]\{7\}' | head -1 |
                xargs -I % sh -c 'git show --color=always % | less -R') << 'FZF-EOF'
                {}
FZF-EOF"
}


# fshow_preview - git commit browser with previews
fshow_preview() {
    glNoGraph |
        fzf --no-sort --reverse --tiebreak=index --no-multi \
            --ansi --preview="$_viewGitLogLine" \
                --header "enter to view, ctrl-w to copy hash" \
                --bind "enter:execute:$_viewGitLogLine   | less -R" \
                --bind "ctrl-w:execute:$_gitLogLineToHash | pbcopy" \
				--height 100% \
				--border
}


#########
#  NNN  #
#########

n ()
{
    # Block nesting of nnn in subshells
    if [ -n $NNNLVL ] && [ "${NNNLVL:-0}" -ge 1 ]; then
        echo "nnn is already running"
        return
    fi

    # The behaviour is set to cd on quit (nnn checks if NNN_TMPFILE is set)
    # To cd on quit only on ^G, either remove the "export" as in:
    #    NNN_TMPFILE="${XDG_CONFIG_HOME:-$HOME/.config}/nnn/.lastd"
    #    (or, to a custom path: NNN_TMPFILE=/tmp/.lastd)
    # or, export NNN_TMPFILE after nnn invocation
    export NNN_TMPFILE="${XDG_CONFIG_HOME:-$HOME/.config}/nnn/.lastd"

    # Unmask ^Q (, ^V etc.) (if required, see `stty -a`) to Quit nnn
    # stty start undef
    # stty stop undef
    # stty lwrap undef
    # stty lnext undef

    nnn "$@"

    if [ -f "$NNN_TMPFILE" ]; then
            . "$NNN_TMPFILE"
            rm -f "$NNN_TMPFILE" > /dev/null
    fi
}


#############
#  enhancd  *
#############
source $HOME/oss/enhancd/init.sh
export ENHANCD_FILTER=fzf


#############
#   NVIM    *
#############
export VIMRUNTIME=$HOME/nvim-linux64/share/nvim/runtime

typeset -A ZSH_HIGHLIGHT_STYLES
ZSH_HIGHLIGHT_STYLES[path]=underline

FPATH=~/.zsh/plug/zsh-completions:$FPATH

source ~/.zsh/plug/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
source ~/.zsh/plug/zsh-autosuggestions/zsh-autosuggestions.zsh


# Generated for envman. Do not edit.
[ -s "$HOME/.config/envman/load.sh" ] && source "$HOME/.config/envman/load.sh"

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

export PYENV_ROOT="$HOME/.pyenv"
export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init --path)"

eval "$(zoxide init zsh)"
eval "$(starship init zsh)"
export VIMRUNTIME=/home/amabow/nvim-linux64/share/nvim/runtime
export VIMRUNTIME=/home/amabow/nvim-linux64/share/nvim/runtime
