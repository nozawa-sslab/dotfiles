setopt no_beep

exists() { type "$1" > /dev/null 2>&1; }

###########
#  alias  #
###########
if type "lsd" > /dev/null 2>&1; then
	alias ls='lsd'
else
	alias ls='ls --color=auto'
fi

alias zrc='nvim ~/.zshrc'
alias vrc='nvim ~/.vimrc'
alias rel='exec $SHELL -l'
alias clip='(){cat $1 | pbcopy}'
alias pyb='python -m compileall'
alias pbcopy='xclip -selection clipboard'
alias pbpaste='xclip -selection clipboard -o'

# Neovim
alias vi='nvim'
alias vinit='nvim ~/.config/nvim/init.vim'
alias vset='nvim ~/.config/nvim/init/settings.init.vim'

# git
alias gs='git status'

# notification
if exists "python3"; then
  alias notify='python3 ~/notification/notify.py'
fi

##############
# Completion #
##############
autoload -Uz compinit && compinit

#############
# Highlight #
#############
typeset -A ZSH_HIGHLIGHT_STYLES
ZSH_HIGHLIGHT_STYLES[path]=underline

###########
# History #
###########
export HISTFILE="$HOME/.zsh_history"
export HISTSIZE=10000
export SAVEHIST=10000

setopt extended_history
setopt hist_expire_dups_first
setopt hist_ignore_dups
setopt hist_ignore_space
setopt hist_reduce_blanks
setopt share_history

###########################
#  environment variables  #
###########################
export TZ=Asia/Tokyo
export TERM=xterm-256color
export EDITOR="/usr/local/bin/nvim"
export MYVIMRC="$HOME/.config/nvim/init.vim"
export WORDCHARS=${WORDCHARS/\/}

path=(
  ~/.local/bin,
  /usr/local/bin,
  /usr/local/sbin,
  $path
  ~/.cargo/bin,
  ~/oss/bin,
)

# environment variables unique to the local machine
if [ -e "$HOME/.zsh/path.zsh" ]
then
  source "$HOME/.zsh/path.zsh"
fi

export SLACK_INCOMING_WEBHOOK_URL="https://hooks.slack.com/services/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"

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

################
# key bindings #
################
bindkey -v

# zle
# To check key seq, push key after Ctrl-v 
bindkey "^U" backward-kill-line
bindkey "^u" backward-kill-line
bindkey "^[f" forward-word
bindkey "^[b" backward-word
bindkey "^A" beginning-of-line
bindkey "^E" end-of-line

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
#   nvim    *
#############
export VIMRUNTIME=/usr/local/share/nvim/runtime

#############
#  plugins  #
#############
if exists "zoxide"; then
  eval "$(zoxide init zsh)"
fi

if exists "starship"; then
  eval "$(starship init zsh)"
fi

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
bindkey '^ ' autosuggest-accept
zinit light zsh-users/zsh-completions

zinit ice wait lucid
zinit light b4b4r07/enhancd
zinit ice as"command" from"gh-r" \
  atclone"./starship init zsh > init.zsh; ./starship completions zsh > _starship" \
  atpull"%atclone" src"init.zsh"
zinit light starship/starship
zinit ice wait lucid
zinit light asdf-vm/asdf

