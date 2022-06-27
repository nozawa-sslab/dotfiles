#!/bin/sh

# zsh
if type "zsh" > /dev/null 2>&1; then
	echo "zsh does exist!"
else
	sudo apt-get install zsh
	touch $HOME/.zshrc
fi

# zsh plugins
if [ ! -d $HOME/.zsh/plug ]; then
	mkdir -p $HOME/.zsh/plug
fi
ZSH_PLUG_DIR="$HOME/.zsh/plug"

if [ ! -d $ZSH_PLUG_DIR/zsh-syntax-highlighting ]; then
	git clone git@github.com:zsh-users/zsh-syntax-highlighting.git 
	mv zsh-syntax-highlighting $ZSH_PLUG_DIR/
	echo "source $HOME/.zsh/plug/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh" >> $HOME/.zshrc
	echo "\n"
fi

if [ ! -d $ZSH_PLUG_DIR/zsh-autosuggestions ]; then
	git clone git@github.com:zsh-users/zsh-autosuggestions.git
	mv zsh-autosuggestions $ZSH_PLUG_DIR/
	echo "source $HOME/.zsh/plug/zsh-autosuggestions/zsh-autosuggestions.zsh" >> $HOME/.zshrc
	echo "\n"
fi

if [ ! -d $ZSH_PLUG_DIR/zsh-completions ]; then
	git clone git@github.com:zsh-users/zsh-completions.git
	mv zsh-completions $ZSH_PLUG_DIR/
	echo 'export HISTFILE="$HOME/.zsh_histroty"' >> $HOME/.zshrc
	echo 'export HISTSIZE=2000' >> $HOME/.zshrc
	echo 'export SAVEHIST=1000' >> $HOME/.zshrc
	echo "autoload -Uz compinit && compinit" >> $HOME/.zshrc
	echo "fpath=($ZSH_PLUG_DIR/zsh-completions:$fpath)" >> $HOME/.zshrc
	echo "\n"
fi

# starship
if type "starship" > /dev/null 2>&1; then
	echo "starship does exist!"
else
	echo "\n"
	echo "starship does not exist!"
	echo "\n"
	sleep 0.1
## install FiraCode Nerd Fonts
	sudo apt install fontconfig
	wget https://github.com/ryanoasis/nerd-fonts/releases/download/v2.1.0/FiraCode.zip
	if [ ! -d $HOME/.fonts]; then
		mkdir $HOME/.fonts
	fi
	unzip FiraCode.zip -d $HOME/.fonts
	fc-cache -fv

## install Cargo and libssl-dev
	sudo apt install libssl-dev pkg-config
	sudo apt install cargo

## finally install starhsip binary
	sh -c "$(curl -fsSL https://starship.rs/install.sh)"
fi

if type "z" > /dev/null 2>&1; then
	echo "zoxide does exist!"
else
	echo "\n"
	echo "zoxide does not exist!"
	echo "\n"
	sleep 0.1
	curl -sS https://webinstall.dev/zoxide | bash
fi

# Neovim
if type "nvim" > /dev/null 2>&1; then
	echo "Neovim does exist!"
else
	echo "\n"
	echo "neovim does not exist!"
	echo "\n"
	sleep 0.1
	wget https://github.com/neovim/neovim/releases/download/v0.7.2/nvim-linux64.tar.gz
	tar xzvf nvim-linux64.tar.gz
	cp ./nvim-linux64/bin/nvim $HOME/oss/bin/
	echo "export VIMRUNTIME=$HOME/nvim-linux64/share/nvim/runtime" >> .zshrc
fi

# dein.vim
if [ ! -d $HOME/.config/nvim/dein ]; then
	mkdir -p $HOME/.config/nvim/dein

	curl https://raw.githubusercontent.com/Shougo/dein.vim/master/bin/installer.sh > $HOME/.config/nvim/dein/installer.sh
	sh $HOME/.config/nvim/dein/installer.sh $HOME/.config/nvim/dein

	cp -r $HOME/dotfiles/.config/nvim/init* $HOME/.config/nvim/
	cp $HOME/dotfiles/.config/nvim/*toml $HOME/.config/nvim/
fi

# coc.nvim
if type "nvm" > /dev/null 2>&1; then
	echo "nvm does exist!"
else
	echo "\n"
	echo "nvm does not exist!"
	echo "\n"
	sleep 0.1
	#sh -c "$(curl https://raw.githubusercontent.com/creationix/nvm/master/install.sh)"
	curl https://raw.githubusercontent.com/creationix/nvm/master/install.sh | bash
	mkdir $HOME/.npm_global
	npm config set prefix=$HOME/.npm_global
	nvm install --lts
	npm install yarn
	yarn --cwd $HOME/.config/nvim/dein/repos/github.com/neoclide/coc.nvim install
fi

# fzf
if type "fzf" > /dev/null 2>&1; then
	echo "fzf does exist!"
else
	echo "\n"
	echo "fzf does not exist!"
	echo "\n"
	sleep 0.1
	sudo apt-get install fzf
	echo "export FZF_DEFAULT_OPTS='--height 40% --layout=reverse --border'" >> $HOME/.zshrc	
	echo "export FZF_CTRL_T_COMMAND='rg --files --hidden --follow --glob \"!.git/*\"'" >> $HOME/.zshrc
	echo "export FZF_CTRL_T_OPTS='--preview \"bat  --color=always --style=header,grid --line-range :100 {}\"'"
fi

# bat
if type "bat" > /dev/null 2>&1; then
	echo "bat does exist!"
else
	echo "\n"
	echo "bat does not exist!"
	echo "\n"
	sleep 0.1
	sudo apt install bat
	parent_dir=$(dirname $(which batcat))
	sudo ln -s $(which batcat) $parent_dir/bat
fi

# rip-grep
if type "rg" > /dev/null 2>&1; then
	echo "ripgrep does exist!"
else
	echo "\n"
	echo "ripgrep does not exist!"
	echo "\n"
	sleep 0.1
	sudo apt install -o Dpkg::Options::="--force-overwrite" bat ripgrep
fi

# pyenv
if type "pyenv" > /dev/null 2>&1 ; then
	echo "pyenv does exist"
else
	echo "\n"
	echo "pyenv does not exist!"
	echo "\n"
	sleep 0.1
	sudo apt-get update; sudo apt-get install make build-essential libssl-dev zlib1g-dev \
		libbz2-dev libreadline-dev libsqlite3-dev wget curl llvm \
		libncursesw5-dev xz-utils tk-dev libxml2-dev libxmlsec1-dev libffi-dev liblzma-dev

	curl https://pyenv.run | bash
	exec $SHELL

	pyenv install 3.9.7
	pyenv global 3.9.7
fi

echo "Finished installation!!\n"
echo "Enter following command and Restart a new terminal session:\n\tchsh -s \$(which zsh)\n"
