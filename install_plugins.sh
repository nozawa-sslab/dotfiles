#!/bin/sh
if type "nnn" > /dev/null 2>&1; then
	echo "\nNNN has been installed.\n"
else
	brew install nnn
fi

if test -d ~/oss; then
	mkdir ~/oss
fi

if test -d ~/oss/enhancd; then
	echo "\nenhancd has been installed.\n"
else
	git clone git@github.com:b4b4r07/enhancd.git ~oss/enhancd
fi

if test -d ~/.zsh/plug/zsh-syntax-highlighting; then
	echo "zsh-syntax-highlighting has been installed."
else
	git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ~/.zsh/plug/zsh-syntax-highlighting
fi

if test -d ~/.zsh/plug/zsh-autosuggestions; then
	echo "zsh-autosuggestions has been installed."
else
	git clone https://github.com/zsh-users/zsh-autosuggestions ~/.zsh/plug/zsh-autosuggestions
fi


if [ ! -e ~/.vim/pack/vendor/start ]; then
	mkdir -p ~/.vim/pack/vendor/start
fi

if [ ! -e  ~/.vim/pack/vendor/start/auto-pairs ]; then
	git clone https://github.com/jiangmiao/auto-pairs.git
fi

if [ ! -e  ~/.vim/pack/vendor/start/iceberg.vim ]; then
	git clone https://github.com/cocopon/iceberg.vim.git
fi
