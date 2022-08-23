#!/bin/sh
rm $HOME/.zshrc
ln -s $HOME/dotfiles/.zshrc $HOME/.zshrc

rm $HOME/.config/nvim/init/settings.init.vim
ln -s $HOME/dotfiles/.config/nvim/init/settings.init.vim $HOME/.config/nvim/init/settings.init.vim
