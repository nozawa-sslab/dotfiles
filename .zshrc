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
export PATH="$HOME/oss/julia/:$PATH"

export PROPOSAL_DIR="$HOME/research/serialize/mymethod"

export PYTHONPATH="/home/nozawa/.pyenv/versions/3.9.7/lib/python3.9/site-packages/"
export PYTHONPATH="/home/nozawa/research/mymmap/:$PYTHONPATH"
export PYTHONPATH="/home/nozawa/.pyenv/versions/3.9.7/lib/python3.9/site-packages/:$PYTHONPATH"

# for backward-kill-word
export WORDCHARS=${WORDCHARS/\/}

export SLACK_INCOMING_WEBHOOK_URL="https://hooks.slack.com/services/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"

# clang's {include, library} path
export CPATH="/home/nozawa/.pyenv/versions/3.9.7/include/python3.9/:/home/nozawa/.pyenv/versions/3.9.7/lib/python3.9/site-packages/numpy/core/include:/usr/local/lib/python3.9/site-packages/numpy/core/include:/usr/local/opt/python@3.9/Frameworks/Python.framework/Versions/3.9/include/python3.9"
export CPATH="/home/nozawa/.local/include:$CPATH"
export CPATH="/home/nozawa/research/mymmap:$CPATH"
export LD_LIBRARY_PATH="/home/nozawa/.local/lib:$LIBRARY_PATH"
export LD_LIBRARY_PATH="$CPATH:$LIBRARY_PATH"

typeset -A ZSH_HIGHLIGHT_STYLES
ZSH_HIGHLIGHT_STYLES[path]=underline

FPATH=~/.zsh/plug/zsh-completions:$FPATH

source ~/.zsh/plug/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
source ~/.zsh/plug/zsh-autosuggestions/zsh-autosuggestions.zsh

export EDITOR="nvim"
bindkey \^U backward-kill-line
bindkey "^[f" forward-word
bindkey "^[b" backward-word
bindkey "^A" beginning-of-line
bindkey "^E" end-of-line
bindkey '^ ' autosuggest-accept

# less color
export LESS='-g -i -M -R -W -z-4 -j20'
#  --no-init --quit-if-one-screen
export LESS_TERMCAP_mb=$'\e[1;69m'
export LESS_TERMCAP_md=$'\e[1;69m'
export LESS_TERMCAP_me=$'\e[0m'
export LESS_TERMCAP_se=$'\e[0m'
export LESS_TERMCAP_so=$'\e[48;5;200m'
export LESS_TERMCAP_ue=$'\e[0m'
export LESS_TERMCAP_us=$'\e[1;4;32m'
# termcap terminfo  
# ks      smkx      make the keypad send commands
# ke      rmkx      make the keypad send digits
# vb      flash     emit visual bell
# mb      blink     start blink
# md      bold      start bold
# me      sgr0      turn off bold, blink and underline
# so      smso      start standout (reverse video)
# se      rmso      stop standout
# us      smul      start underline
# ue      rmul      stop underline

#########
#  FZF  #
#########
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

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
#export VIMRUNTIME=$HOME/nvim-linux64/share/nvim/runtime


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
