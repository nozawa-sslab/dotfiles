# zsh
if type "zsh" > /dev/null 2>&1; then
	echo "zsh does exist!"
else
	sudo apt-get install zsh
	touch ~/.zshrc
fi

# zsh plugins
if [ ! -d ~/.zsh/plug ]; then
	mkdir -p ~/.zsh/plug
fi
ZSH_PLUG_DIR="$HOME/.zsh/plug"

if [ ! -d $ZSH_PLUG_DIR/zsh-syntax-highlighting ]; then
	git clone git@github.com:zsh-users/zsh-syntax-highlighting.git 
	mv zsh-syntax-highlighting $ZSH_PLUG_DIR/
	echo "source ~/.zsh/plug/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh" >> ~/.zshrc
fi

if [ ! -d $ZSH_PLUG_DIR/zsh-autosuggestions ]; then
	git clone git@github.com:zsh-users/zsh-autosuggestions 
	mv zsh-autosuggestions $ZSH_PLUG_DIR/
	echo "source ~/.zsh/plug/zsh-autosuggestions/zsh-autosuggestions.zsh" >> ~/.zshrc
fi

if [ ! -d $ZSH_PLUG_DIR/zsh-completions ]; then
	git clone git://github.com/zsh-users/zsh-completions.git
	mv zsh-completions $ZSH_PLUG_DIR/
	echo "autoload -Uz compinit && compinit" >> ~/.zshrc
	echo "fpath=(path/to/zsh-completions/src $fpath)" >> ~/.zshrc
fi

# starship
if type "starship" > /dev/null 2>&1; then
	echo "starship does exist!"
else
## install FiraCode Nerd Fonts
	sudo apt install fontconfig
	wget https://github.com/ryanoasis/nerd-fonts/releases/download/v2.1.0/FiraCode.zip
	if [ ! -d ~/.fonts]; then
		mkdir ~/.fonts
	fi
	unzip FiraCode.zip -d ~/.fonts
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
	sh -c "$(curl -sS https://webinstall.dev/zoxide)"
fi

# Neovim
if type "nvim" > /dev/null 2>&1; then
	echo "Neovim does exist!"
else
	sudo apt install neovim
fi

# dein.vim
if [ ! -d ~/.config/nvim/dein ]; then
	mkdir -p ~/.config/nvim/dein

	curl https://raw.githubusercontent.com/Shougo/dein.vim/master/bin/installer.sh > ~/.config/nvim/dein/installer.sh
	sh ~/.config/nvim/dein/installer.sh ~/.config/nvim/dein

	cp -r ~/dotfiles/.config/nvim/init* ~/.config/nvim/
	cp dotfiles/.config/nvim/*toml ~/.config/nvim/
fi

# coc.nvim
if type "nvm" > /dev/null 2>&1; then
	echo "nvm does exist!"
else
	sh -c "$(curl https://raw.githubusercontent.com/creationix/nvm/master/install.sh)"
	nvm install --lts
	npm install -g yarn
	yarn --cwd ~/.config/nvim/dein/repos/github.com/neoclide/coc.nvim install
fi

# fzf
if type "fzf" > /dev/null 2>&1; then
	echo "fzf does exist!"
else
	echo "fzf does not exist!"
	sudo apt-get install fzf
fi

# bat
if type "bat" > /dev/null 2>&1; then
	echo "bat does exist!"
else
	echo "bat does not exist!"
	sudo apt install bat
fi

# rip-grep
if type "rg" > /dev/null 2>&1; then
	echo "ripgrep does exist!"
else
	echo "ripgrep does not exist!"
	sudo apt install -o Dpkg::Options::="--force-overwrite" bat ripgrep
fi

echo "Finished installation!!\n"
echo "Enter following command and start a new terminal session:\n\n\tchsh -s \$(which zsh)\n\n"
