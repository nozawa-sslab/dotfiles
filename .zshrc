setopt no_beep

source $HOME/.cargo/env

# max # of file descriptor
ulimit -n 4096

export TERM=xterm-256color

# path
# oss
export PATH="$HOME/oss/bin:$PATH"
# llvm
export PATH="/usr/local/opt/llvm/bin:$PATH"
# julialang
export PATH="$JULIA_DIR/bin:$PATH"
export JULIA_DIR="/Applications/Julia-1.6.app/Contents/Resources/Julia"
# x-code
export PATH="/Users/masa/Downloads/Xcode-beta.app/Contents/Developer/Toolchains/XcodeDefault.xctoolchain/usr/bin:$PATH"
# gcc header search path
export CPATH="/usr/local/lib/python3.9/site-packages/numpy/core/include:/usr/local/opt/python@3.9/Frameworks/Python.framework/Versions/3.9/include/python3.9:/usr/local/include"
# python import
export PYTHONPATH="/Users/masa/.pyenv/versions/3.9.7/lib/python3.9/site-packages:$PYTHONPATH"
# radigo
export RADIGO_HOME=$HOME/radigo_record

# alias
if type "gls" > /dev/null 2>&1; then
	alias ls='gls --color=auto'
	alias ll='gls -al --color=auto'
	alias la='gls -a --color=auto'
fi

if type "gsed" > /dev/null 2>&1; then
	alias sed='gsed'
fi

alias val='nvim ~/.zsh/aliases.sh'
alias ps='ps -j'
alias zrc='nvim ~/.zshrc'
alias vrc='nvim ~/.vimrc'
alias arc='nvim ~/.config/alacritty/alacritty.yml'
alias rel='exec $SHELL -l'
alias ctags="`brew --prefix`/bin/ctags"
alias fbat='fzf --preview "bat  --color=always --style=header,grid --line-range :100 {}"'
alias vstar='nvim ~/.config/starship.toml'
alias chrome='open -a "google chrome"'
alias clip='(){cat $1 | pbcopy}'
alias python='python3'
alias pyb='python3 -m compileall'
alias vf='nvim $(fzf)'
alias cd..='cd ../'
# cdf - cd into the directory of the selected file
cdf() {
   local file
   local dir
   file=$(fzf +m -q "$1") && dir=$(dirname "$file") && cd "$dir"
}

# alias for Neovim
alias vi='nvim'
alias vinit='nvim ~/.config/nvim/init.vim'
alias vset='nvim ~/.config/nvim/init/settings.init.vim'
alias dinit='nvim ~/.config/nvim/init/dein.init.vim'
alias vtoml='nvim ~/.config/nvim/dein.toml'
alias vlazy='nvim ~/.config/nvim/dein_lazy.toml'

# alias for git
alias gs='git status'

# alias for python
alias pet='python setup.py install'
alias note='jupyter notebook'

# alias for ssh tunneling
alias socks='ssh -D localhost:1080 pegasus -N -T'
alias socksf='ssh -fND localhost:8080 pegasus.remote'

# zinit

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
zinit ice wait lucid
zinit light zsh-users/zsh-completions
zinit ice wait lucid
zinit light b4b4r07/enhancd
zinit ice as"command" from"gh-r" \
          atclone"./starship init zsh > init.zsh; ./starship completions zsh > _starship" \
          atpull"%atclone" src"init.zsh"
zinit light starship/starship
zinit ice wait lucid
zinit light asdf-vm/asdf

typeset -A ZSH_HIGHLIGHT_STYLES
ZSH_HIGHLIGHT_STYLES[path]=underline

# zle
# To check key seq, push key after Ctrl-v 
bindkey "^U" backward-kill-line
bindkey "^u" backward-kill-line
bindkey "^[f" forward-word
bindkey "^[b" backward-word
bindkey "^A" beginning-of-line
bindkey "^E" end-of-line
bindkey '^ ' autosuggest-accept

export EDITOR="/usr/local/bin/nvim"

# token seperator for zsh
export WORDCHARS=${WORDCHARS/\/}

export HISTFILE=$HOME/.zsh_history
export HISTSIZE=10000
export SAVEHIST=10000


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

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

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


####################
# pygments for pdf #
####################
pyg() {
	pygmentize -f html -O noclasses=True,linenos=inline,style=abap -l c 
}


#eval "$(pyenv init -)"
#eval "$(pyenv virtualenv-init -)"
eval "$(zoxide init zsh)"
