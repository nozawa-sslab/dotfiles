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

# Neovim
alias vi='nvim'
alias vim='nvim'
alias vinit='nvim ~/.config/nvim/init.vim'
alias vset='nvim ~/.config/nvim/init/settings.init.vim'
alias dinit='nvim ~/.config/nvim/init/dein.init.vim'
alias vtoml='nvim ~/.config/nvim/dein.toml'
alias vlazy='nvim ~/.config/nvim/dein_lazy.toml'

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

source ~/research/serialize/mymethod/setup.sh

autoload -Uz compinit && compinit

export TZ=Asia/Tokyo
export TERM=xterm-256color

export EDITOR="/usr/local/bin/nvim"
# token seperator for zsh
export WORDCHARS=${WORDCHARS/\/}

export HISTFILE=$HOME/.zsh_history
export HISTSIZE=10000
export SAVEHIST=10000

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
export PYTHONPATH="/home/nozawa/.asdf/installs/python/3.9.7/lib/python3.9/site-packages"

# for backward-kill-word
export WORDCHARS=${WORDCHARS/\/}

export SLACK_INCOMING_WEBHOOK_URL="https://hooks.slack.com/services/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"

# clang's {include, library} path
export CPATH="/home/nozawa/.pyenv/versions/3.9.7/include/python3.9/:/home/nozawa/.pyenv/versions/3.9.7/lib/python3.9/site-packages/numpy/core/include:/usr/local/lib/python3.9/site-packages/numpy/core/include:/usr/local/opt/python@3.9/Frameworks/Python.framework/Versions/3.9/include/python3.9"
export CPATH="/home/nozawa/.local/include:$CPATH"
export CPATH="/home/nozawa/research/mymmap:$CPATH"
export LD_LIBRARY_PATH="/home/nozawa/.local/lib:$LIBRARY_PATH"
export LD_LIBRARY_PATH="$CPATH:$LIBRARY_PATH"

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

#############
#  enhancd  *
#############
source $HOME/oss/enhancd/init.sh
export ENHANCD_FILTER=fzf


#############
#   NVIM    *
#############
export VIMRUNTIME=$HOME/oss/neovim/runtime

eval "$(zoxide init zsh)"
eval "$(starship init zsh)"

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
zinit ice wait lucid
zinit light b4b4r07/enhancd
zinit ice as"command" from"gh-r" \
          atclone"./starship init zsh > init.zsh; ./starship completions zsh > _starship" \
          atpull"%atclone" src"init.zsh"
zinit light starship/starship
zinit ice wait lucid
zinit light asdf-vm/asdf
zinit ice wiat lucid
zinit light BurntSushi/ripgrep
# sharkdp/bat
zinit ice as"command" from"gh-r" mv"bat* -> bat" pick"bat/bat"
zinit light sharkdp/bat

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
bindkey '^ ' autosuggest-accept
