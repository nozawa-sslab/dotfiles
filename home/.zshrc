# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# local .zshrc
if [ -e "$HOME/.zshrc_local.zsh" ]
then
  source "$HOME/.zshrc_local.zsh"
fi

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
alias vinit='nvim ~/.config/nvim/init.lua'

# git
alias gs='git status'

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
export EDITOR=nvim
export VISUAL=$EDITOR
export MYVIMRC="$HOME/.config/nvim/init.vim"
export WORDCHARS=${WORDCHARS/\/}

path=(
  ~/.local/bin
  /usr/local/bin
  /usr/local/sbin
  $path
  ~/.cargo/bin
  ~/oss/bin
)

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
if [[ -f ~/.fzf.zsh ]]; then
  source ~/.fzf.zsh
  
  if type "fzf" > /dev/null 2>&1; then
          export FZF_DEFAULT_OPTS='--height 40% --layout=reverse --border --preview "bat --color=always --style=header,grid --line-range :100 {}"'
          export FZF_DEFAULT_COMMAND='rg --files --hidden --follow --glob "!.git/*"'
          export FZF_CTRL_T_COMMAND='rg --files --hidden --follow --glob "!.git/*"'
          export FZF_CTRL_T_OPTS='--preview "bat --color=always --style=header,grid --line-range :100 {}"'
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
fi


#############
#  plugins  #
#############
if exists "zoxide"; then
  eval "$(zoxide init zsh --cmd cd)"
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
zinit light asdf-vm/asdf

# Load powerlevel10k theme
zinit ice depth"1" # git clone depth
zinit light romkatv/powerlevel10k

# fzf
zinit ice atclone"./install"
zinit light junegunn/fzf

# ripgrep
zinit ice from"gh-r" as"program"
zinit light BurntSushi/ripgrep

# bat
zinit ice as"command" from"gh-r" mv"bat* -> bat" pick"bat/bat"
zinit light sharkdp/bat

# lsd
zinit ice from"gh-r" as"program" mv"lsd* -> lsd" pick"lsd/lsd"
zinit light lsd-rs/lsd

# gitui
zinit ice from"gh-r" as"program"
zinit light extrawurst/gitui

# zoxide
zinit ice from"gh-r" as"program"
zinit light ajeetdsouza/zoxide

# delta
zinit ice from"gh-r" as"program" mv"delta* -> delta" pick"delta/delta"
zinit light dandavison/delta

# neovim
zinit ice from"gh-r" as"program" mv"nvim* -> nvim" pick"nvim/bin/nvim"
zinit light neovim/neovim

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
