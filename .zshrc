setopt no_beep

source ~/.zsh/aliases.sh
source $HOME/.cargo/env

autoload -Uz compinit && compinit

# max # of file descriptor
ulimit -n 4096

export TERM=xterm-256color
export JULIA_DIR="/Applications/Julia-1.6.app/Contents/Resources/Julia"
export PATH="$JULIA_DIR/bin:$PATH"
export PATH="$HOME/oss/bin:$PATH"

export CPATH="/usr/local/lib/python3.9/site-packages/numpy/core/include:/usr/local/opt/python@3.9/Frameworks/Python.framework/Versions/3.9/include/python3.9:/usr/local/include"

export PYTHONPATH="/Users/masa/.pyenv/versions/3.9.7/lib/python3.9/site-packages:$PYTHONPATH"

# for qt
#export LDFLAGS="-L/usr/local/opt/llvm/lib"
#export CPPFLAGS="-I/usr/local/opt/llvm/include"

typeset -A ZSH_HIGHLIGHT_STYLES
ZSH_HIGHLIGHT_STYLES[path]=underline

if type brew &>/dev/null; then
    FPATH=$(brew --prefix)/share/zsh-completions:$FPATH

    autoload -Uz compinit
    compinit
fi

if test -d ~/.zsh/plug/zsh-syntax-highlighting; then
	source ~/.zsh/plug/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
fi

if test -d ~/.zsh/plug/zsh-autosuggestions; then
	source ~/.zsh/plug/zsh-autosuggestions/zsh-autosuggestions.zsh
fi

export EDITOR="/usr/local/bin/nvim"

# To check key seq, push key after Ctrl-v 
bindkey "^U" backward-kill-line
bindkey "^u" backward-kill-line
bindkey "^[f" forward-word
bindkey "^[b" backward-word
bindkey "^A" beginning-of-line
bindkey "^E" end-of-line
bindkey '^ ' autosuggest-accept

export HISTFILE=$HOME/.zsh_history
export HISTSIZE=10000
export SAVEHIST=10000

export RADIGO_HOME=$HOME/radigo_record

export WORDCHARS=${WORDCHARS/\/}

#########
#  FZF  *
#########
if type "fzf" > /dev/null 2>&1; then
	export FZF_DEFAULT_OPTS='--multi --height 40% --layout=reverse --border'
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

#############
#  enhancd  *
#############
source $HOME/oss/enhancd/init.sh
export ENHANCD_FILTER=fzf


#########
#  NNN  *
#########
export NNN_BMS="h:$HOME"
export NNN_FIFO=/tmp/nnn.fifo
export NNN_PLUG='1:ipinfo;p:preview-tui;o:fzz;b:nbak'
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

nnn_cd()                                                                                                   
{
    if ! [ -z "$NNN_PIPE" ]; then
        printf "%s\0" "0c${PWD}" > "${NNN_PIPE}" !&
    fi  
}

trap nnn_cd EXIT


####################
# pygments for pdf #
####################
pyg() {
	pygmentize -f html -O noclasses=True,linenos=inline,style=abap -l c 
}


source ~/.zsh/functions.sh

eval "$(zoxide init zsh)"
eval "$(starship init zsh)"
eval "$(pyenv init -)"

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

export PATH="$HOME/.poetry/bin:$PATH"
export PATH="/usr/local/opt/llvm/bin:$PATH"
