
if type "gls" > /dev/null 2>&1; then
	alias ls='gls --color=auto'
fi

alias zrc='nvim ~/.zshrc'
alias rel='exec $SHELL -l'
alias python='python3'
alias ctags="`brew --prefix`/bin/ctags"
alias fbat='fzf --preview "bat  --color=always --style=header,grid --line-range :100 {}"'
alias vstar='nvim ~/.config/starship.toml'
alias chrome='open -a "google chrome"'

# Neovim
alias vi='nvim'
alias vinit='nvim ~/.config/nvim/init.vim'
alias vset='nvim ~/.config/nvim/init/settings.init.vim'
alias dinit='nvim ~/.config/nvim/init/dein.init.vim'
alias vtoml='nvim ~/.config/nvim/dein.toml'
alias vlazy='nvim ~/.config/nvim/dein_lazy.toml'



