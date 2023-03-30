# Setup fzf
# ---------
if [[ ! "$PATH" == */home/nozawa/.config/nvim/dein/repos/github.com/junegunn/fzf/bin* ]]; then
  PATH="${PATH:+${PATH}:}/home/nozawa/.config/nvim/dein/repos/github.com/junegunn/fzf/bin"
fi

# Auto-completion
# ---------------
[[ $- == *i* ]] && source "/home/nozawa/.config/nvim/dein/repos/github.com/junegunn/fzf/shell/completion.zsh" 2> /dev/null

# Key bindings
# ------------
source "$HOME/.local/share/nvim/plugged/fzf/shell/key-bindings.zsh"

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

