# cp $HOME/dotfiles/.zshrc $HOME/.zshrc
# cp $HOME/dotfiles/.zsh/aliases.sh $HOME/aliases.sh
# 
# cp $HOME/dotfiles/.tmux.conf $HOME/.tmux.conf
# 
# cp $HOME/dotfiles/.config/starship.toml $HOME/starship.toml

import os
import subprocess as sb

HOME = os.environ["HOME"]
DOTFILES_HOME = os.path.join(HOME, "dotfiles")
NVIM_HOME = os.path.join(HOME, ".config", "nvim")

def cmd(arg):
    return sb.run(arg, capture_output=True)

cmd(["cp", os.path.join(DOTFILES_HOME, ".zshrc"), os.path.join(HOME, ".zshrc")]) 
cmd(["cp", os.path.join(DOTFILES_HOME, ".zsh", "aliases.sh"), os.path.join(HOME, ".zsh", "aliases.sh")])
cmd(["cp", os.path.join(DOTFILES_HOME, ".tmux.conf"), os.path.join(HOME, ".tmux.conf")]) 
cmd(["cp", os.path.join(DOTFILES_HOME, ".gitconfig"), os.path.join(HOME, ".gitconfig")])
cmd(["cp", os.path.join(DOTFILES_HOME, ".clang-format"), os.path.join(HOME, ".clang-format")])
cmd(["cp", os.path.join(DOTFILES_HOME, ".config", "starship.toml"), os.path.join(HOME, ".config", "starship.toml")])

NVIM_HOME_IN_DOTFILES = os.path.join(DOTFILES_HOME, ".config", "nvim")
files = os.listdir(NVIM_HOME_IN_DOTFILES)
for file in files:
    filepath = os.path.join(NVIM_HOME_IN_DOTFILES, "nvim")
    if os.path.isfile(filepath):
        cmd(["cp", filepath, os.path.join(NVIM_HOME, file)]) 
    elif os.path.isdir(filepath) and file == "init":
        # inside init.vim
        files_in_init = os.listdir(filepath)
        for file_in_init in files_in_init:
            filepath_ = os.path.join(filepath, file_in_init)
            if os.path.isfile(filepath_):
                cmd(["cp", filepath_, os.path.join(NVIM_HOME, file_in_init)]) 
