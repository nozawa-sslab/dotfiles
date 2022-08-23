#!/bin/sh

if [ ! -e ~/.vim/pack/vendor/start ]; then
	mkdir -p ~/.vim/pack/vendor/start
fi

if [ ! -e  ~/.vim/pack/vendor/start/auto-pairs ]; then
	git clone https://github.com/jiangmiao/auto-pairs.git ~/.vim/pack/vendor/start
fi

if [ ! -e  ~/.vim/pack/vendor/start/iceberg.vim ]; then
	git clone https://github.com/cocopon/iceberg.vim.git ~/.vim/pack/vendor/start
fi

sudo apt install nnn

if test -d ~/oss; then
	mkdir ~/oss
fi

if ! test -d ~/oss/enhancd; then
	git clone git@github.com:b4b4r07/enhancd.git ~/oss/enhancd
fi
