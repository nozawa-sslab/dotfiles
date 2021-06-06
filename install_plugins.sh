#!/bin/sh

if [ ! -e ~/.vim/pack/vendor/start ]; then
	mkdir -p ~/.vim/pack/vendor/start
fi

if [ ! -e  ~/.vim/pack/vendor/start/auto-pairs ]; then
	git clone https://github.com/jiangmiao/auto-pairs.git
fi

if [ ! -e  ~/.vim/pack/vendor/start/iceberg.vim ]; then
	git clone https://github.com/cocopon/iceberg.vim.git
fi
