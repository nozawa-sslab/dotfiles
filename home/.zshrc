setopt no_beep

# alias
if type "gls" > /dev/null 2>&1; then
	alias ls='gls --color=auto'
	alias ll='gls -l --color=auto'
else
	alias ls='ls --color=auto'
	alias ll='ls -l --color=auto'
fi

alias val='nvim ~/.zsh/aliases.sh'
alias vf='nvim $(fzf)'
alias ps='ps -j'
alias zrc='nvim ~/.zshrc'
alias vrc='nvim ~/.vimrc'
alias rel='exec $SHELL -l'
alias fbat='fzf --preview "bat  --color=always --style=header,grid --line-range :100 {}"'
alias vstar='nvim ~/.config/starship.toml'
alias chrome='open -a "google chrome"'
alias clip='(){cat $1 | pbcopy}'
alias lab='jupyter lab --no-browser --port=8888'
alias pyb='python -m compileall'
alias pbcopy='xclip -selection clipboard'
alias pbpaste='xclip -selection clipboard -o'
alias crontab='crontab -i'
alias ..='cd ../'
alias cd..='cd ../'

# Neovim
alias vi='nvim'
alias vim='nvim'
alias vinit='nvim ~/.config/nvim/init.vim'
alias vset='nvim ~/.config/nvim/init/settings.init.vim'
alias dinit='nvim ~/.config/nvim/init/dein.init.vim'
alias vtoml='nvim ~/.config/nvim/dein.toml'
alias vlazy='nvim ~/.config/nvim/dein_lazy.toml'
export VIMRC=$HOME/.config/nvim/init.vim

# git
alias gs='git status'

# notification
alias notify='python ~/notification/notify.py'

#jupyter notebook
function  jpt(){
    # Fires-up a Jupyter notebook by supplying a specific port
    jupyter notebook --no-browser --port=$1
}

source $HOME/.cargo/env

autoload -Uz compinit && compinit

export TZ=Asia/Tokyo
export TERM=xterm-256color

export EDITOR="/usr/local/bin/nvim"
# token seperator for zsh
export WORDCHARS=${WORDCHARS/\/}

export HISTFILE=$HOME/.zsh_history
export HISTSIZE=10000
export SAVEHIST=10000

export PATH="$HOME/.asdf/installs/python/3.9.7/bin/:$PATH"
export PATH="/opt/homebrew/bin:$PATH"
export PATH="$JULIA_DIR/bin:$PATH"
export PATH="$HOME/.cargo/bin:$PATH"
export PATH="$HOME/.local/bin:$PATH"
export PATH="$HOME/oss/bin:$PATH"
export PATH="$HOME/node_modules/:$PATH"
export PATH="$HOME/.npm_global/bin:$PATH"
export PATH="$HOME/oss/julia/:$PATH"

export PYTHONPATH="/home/nozawa/.asdf/installs/python/3.9.7/lib/python3.9/site-packages:$PYTHONPATH"
export PYTHONPATH="/home/nozawa/oss/yapf/:$PYTHONPATH"

# for backward-kill-word
export WORDCHARS=${WORDCHARS/\/}

export SLACK_INCOMING_WEBHOOK_URL="https://hooks.slack.com/services/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"

# clang's {include, library} path
export CPATH="/home/nozawa/.asdf/installs/python/3.9.7/include/python3.9/"
export CPATH=/home/nozawa/.asdf/installs/python/3.9.7/lib/python3.9/site-packages/numpy/core/include:$CPATH
export CPATH="/home/nozawa/.local/include:$CPATH"
## for research
export CPATH="/home/nozawa/research/mymmap:$CPATH"
export CPATH=$HOME/oss/julia/usr/include:$CPATH
export CPATH=$HOME/oss/julia/usr/include/julia:$CPATH
export CPATH=$HOME/research/directchange-prototype/include:$CPATH
export CPATH=$HOME/research/master-proposal/include:$CPATH
export CPATH=$HOME/research/master-proposal/meta-server:$CPATH
export CPATH=$HOME/oss/arrow/cpp/build/src/arrow:$CPATH
export CPATH=$HOME/oss/dist/include/:$CPATH
export LD_LIBRARY_PATH="/home/nozawa/.local/lib:$LIBRARY_PATH"
export LD_LIBRARY_PATH="$CPATH:$LD_LIBRARY_PATH"
export LD_LIBRARY_PATH="$HOME/oss/dist/lib:$LD_LIBRARY_PATH"
export LD_LIBRARY_PATH="$HOME/research/master-proposal/meta-server/build/:$LD_LIBRARY_PATH"

# julia's LOAD_PATh
export JULIA_LOAD_PATH="/home/nozawa/research/master-proposal/julia/src:$JULIA_LOAD_PATH"

#FPATH=~/.zsh/plug/zsh-completions:$FPATH

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

if type "fzf" > /dev/null 2>&1; then
	export FZF_DEFAULT_OPTS='--height 40% --layout=reverse --border'
	export FZF_DEFAULT_COMMAND='rg --files --hidden --follow --glob "!.git/*"'
	export FZF_CTRL_T_COMMAND='rg --files --hidden --follow --glob "!.git/*"'
	export FZF_CTRL_T_OPTS='--preview "bat --color=always --style=header,grid --line-range :100 {}"'
  # CTRL-/ to toggle small preview window to see the full command
  # CTRL-Y to copy the command into clipboard using pbcopy
  export FZF_CTRL_R_OPTS=" \
    --preview 'echo {}' --preview-window up:3:hidden:wrap \
    --bind 'ctrl-/:toggle-preview' \
    --bind 'ctrl-y:execute-silent(echo -n {2..} | pbcopy)+abort' \
    --color header:italic \
    --header 'Press CTRL-Y to copy command into clipboard'"
fi

alias glNoGraph='git log --color=always --format="%C(auto)%h%d %s %C(black)%C(bold)%cr% C(auto)%an" "$@"'
_gitLogLineToHash="echo {} | grep -o '[a-f0-9]\{7\}' | head -1"
_viewGitLogLine="$_gitLogLineToHash | xargs -I % sh -c 'git show --color=always % | delta'"


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
export ENHANCD_FILTER=fzf


#############
#   NVIM    *
#############
export VIMRUNTIME=$HOME/oss/neovim/runtime

#########
#  NNN  #
#########
n ()
{
    # Block nesting of nnn in subshells
    if [[ "${NNNLVL:-0}" -ge 1 ]]; then
        echo "nnn is already running"
        return
    fi

    # The behaviour is set to cd on quit (nnn checks if NNN_TMPFILE is set)
    # If NNN_TMPFILE is set to a custom path, it must be exported for nnn to
    # see. To cd on quit only on ^G, remove the "export" and make sure not to
    # use a custom path, i.e. set NNN_TMPFILE *exactly* as follows:
    #     NNN_TMPFILE="${XDG_CONFIG_HOME:-$HOME/.config}/nnn/.lastd"
    export NNN_TMPFILE="${XDG_CONFIG_HOME:-$HOME/.config}/nnn/.lastd"

    # Unmask ^Q (, ^V etc.) (if required, see `stty -a`) to Quit nnn
    # stty start undef
    # stty stop undef
    # stty lwrap undef
    # stty lnext undef

    # The backslash allows one to alias n to nnn if desired without making an
    # infinitely recursive alias
    \nnn "$@"

    if [ -f "$NNN_TMPFILE" ]; then
            . "$NNN_TMPFILE"
            rm -f "$NNN_TMPFILE" > /dev/null
    fi
}

###################
# zinit (plugins) #
###################

### Added by Zinit's installer
if [[ ! -f $HOME/.local/share/zinit/zinit.git/zinit.zsh ]]; then
    print -P "%F{33} %F{220}Installing %F{33}ZDHARMA-CONTINUUM%F{220} Initiative Plugin Manager (%F{33}zdharma-continuum/zinit%F{220})…%f"
    command mkdir -p "$HOME/.local/share/zinit" && command chmod g-rwX "$HOME/.local/share/zinit"
    command git clone https://github.com/zdharma-continuum/zinit "$HOME/.local/share/zinit/zinit.git" && \
        print -P "%F{33} %F{34}Installation successful.%f%b" || \
        print -P "%F{160} The clone has failed.%f%b"
fi

source "$HOME/.local/share/zinit/zinit.git/zinit.zsh"
autoload -Uz _zinit
(( ${+_comps} )) && _comps[zinit]=_zinit

# Load a few important annexes, without Turbo
# (this is currently required for annexes)
zinit light-mode for \
    zdharma-continuum/zinit-annex-as-monitor \
    zdharma-continuum/zinit-annex-bin-gem-node \
    zdharma-continuum/zinit-annex-patch-dl \
    zdharma-continuum/zinit-annex-rust

### End of Zinit's installer chunk

# install and load zsh plugins
zinit light zsh-users/zsh-syntax-highlighting
zinit light zsh-users/zsh-autosuggestions
zinit light zsh-users/zsh-completions
zinit ice as"command" src"init.sh"
zinit light b4b4r07/enhancd
zinit ice as"command" from"gh-r" \
          atclone"./starship init zsh > init.zsh; ./starship completions zsh > _starship" \
          atpull"%atclone" src"init.zsh"
zinit light starship/starship
zinit ice wait lucid
zinit light asdf-vm/asdf
# sharkdp/bat
zinit ice as"command" from"gh-r" mv"bat* -> bat" pick"bat/bat"
zinit light sharkdp/bat
# extrawurst/gitui
zinit ice from"gh-r" as"program"
zinit light extrawurst/gitui

typeset -A ZSH_HIGHLIGHT_STYLES
ZSH_HIGHLIGHT_STYLES[path]=underline

bindkey -v

# zle
# To check key seq, push key after Ctrl-v 
bindkey "^U" backward-kill-line
bindkey "^u" backward-kill-line
bindkey "^[f" forward-word
bindkey "^[b" backward-word
bindkey "^A" beginning-of-line
bindkey "^E" end-of-line
bindkey '^j' autosuggest-accept

eval "$(zoxide init zsh)"
eval "$(starship init zsh)"

ulimit -n 65536
