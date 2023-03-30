#!/bin/bash

# zsh
if type "zsh" > /dev/null 2>&1; then
	echo "zsh does exist!"
else
	sudo apt-get install zsh
fi

DOTFILE_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
[[ -z "$DOTFILE_DIR" ]] && DOTFILE_DIR=~/Library/dotfiles

OSS_DIR=$HOME/oss

main() {
  local install_deps=""
  for n in "$@"; do
    case "$n" in
      --install-deps)
        install_deps=yes
        ;;
      *)
        ;;
    esac
  done

  cd "$DOTFILE_DIR"

  echo "$(tput bold)== Updating submodules ==$(tput sgr0)"
  git submodule update --init --remote

  echo "$(tput bold)== Installing configuration ==$(tput sgr0)"
  setup::shell
  setup::vim
#  setup::gpg
  setup::misc

  if [[ -n "$install_deps" ]]; then
    echo "$(tput bold)== Installing dependencies ==$(tput sgr0)"
    setup::deps
  fi
}

setup::shell() {
  install::default ".bashrc"
  install::default ".zshrc"
  install::default ".tmux.conf"
  install::default ".config/starship.toml"
  install::default ".fzf.zsh"
}

#setup::gpg() {
#}

setup::vim() {
  install::default ".vimrc"
}

setup::misc() {
  install::default ".clang-format"
  install::default ".gitconfig"
}

setup::plugins_mac() {
  xcode-select --install
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
  brew update
  brew install \
    cmake \
    fd \
    ccls \
    nnn \
    tmux

  # install tmux plugin manager
  git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm

  # Required packages for neovim compile. There are some duplicates with above,
  # but we will keep them for the time being.
  brew install \
    ninja \
    libtool \
    cmake \
    pkg-config \
    gettext \
    curl
}

setup::plugins_ubuntu() {
  sudo add-apt-repository ppa:longsleep/golang-backports
  sudo apt update
  sudo apt upgrade
  sudo apt install \
      build-essential \
      cmake \
      git \
      fd-find \
      ccls \
      nnn \
      tmux

  # install tmux plugin manager
  git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm

  # Required packages for neovim compile. There are some duplicates with above,
  # but we will keep them for the time being.
  sudo apt install \
    ninja-build \
    gettext \
    libtool-bin \
    cmake \
    g++ \
    pkg-config \
    unzip \
    curl
}

setup::deps_linux() {
  setup::plugins_ubuntu
}

setup::deps_mac() {
  setup::plugins_mac
}

setup::deps() {
  if [[ $(uname) == "Darwin" ]]; then
    setup::deps_mac
  else
    setup::deps_linux 
  fi

  setup::rust
  setup::oss
}

setup::rust() {
  # Install rust related
  curl https://sh.rustup.rs -sSf | sh
  cargo install gitui
  cargo install git-delta
  cargo install zoxide
}

setup::oss() {
  if [ ! -d $OSS_DIR ]; then
    mkdir -p $OSS_DIR;
  fi
  setup::neovim
  setup::fzf
}

setup::neovim() {
  local nvim_dir=$OSS_DIR/neovim
  local old_pwd="$(pwd)"
  if [ -d nvim_dir ]; then
    return
  fi

  git clone https://github.com/neovim/neovim $nvim_dir

  cd "$nvim_dir"
  git checkout stable
  make CMAKE_BUILD_TYPE=RelWithDebInfo
  sudo make install
  cd "$old_pwd"

  sh -c 'curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim --create-dirs \
         https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
  install::default ".config/nvim/init.vim"
  install::default ".config/nvim/init/settings.init.vim"
  install::default ".config/nvim/init/plug.init.vim"
  install::default ".config/nvim/init/airline.init.vim"
  install::default ".config/nvim/init/coc.init.vim"

  nvim +PlugInstall +qall
}

setup::dein() {
	mkdir -p $HOME/.config/nvim/dein

  local NVIM_CONFIG_DIR=$HOME/.config/nvim
	curl https://raw.githubusercontent.com/Shougo/dein.vim/master/bin/installer.sh > $NVIM_CONFIG_DIR/dein/installer.sh
	sh $NVIM_CONFIG_DIR/dein/installer.sh $NVIM_CONFIG_DIR/dein

  # copy *.init.vim
	cp -r $HOME/dotfiles/.config/nvim/init* $NVIM_CONFIG_DIR
	cp $HOME/dotfiles/.config/nvim/*toml $NVIM_CONFIG_DIR
}

setup::fzf() {
	git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
	~/.fzf/install
}


######################
#  helper functions  #
######################

# Print an error message and exit
# Arguments:
#   error_message [default: abort]
# Returns:
#   None
abort() {
  local message="abort"
  [[ -n "$1" ]] && message="$1"
  printf "[%s():%s] %s\n" "${FUNCNAME[1]}" "${BASH_LINENO[0]}" "$message" >&2
  exit 1
}

# Prints the relative path from the current directory to the given path
# Arguments:
#   path
# Returns:
#   None
# Dependencies:
#   coreutils, python, ruby, or perl
relative_path() {
  [[ "$#" != 1 ]] && abort "Wrong number of arguments."
  if command -v realpath >/dev/null 2>&1; then
    realpath --no-symlinks --relative-to=. "$1"
  elif command -v perl >/dev/null 2>&1; then
    perl -e "use File::Spec; print File::Spec->abs2rel('$1')"
  elif command -v ruby >/dev/null 2>&1; then
    ruby -e \
      "require 'pathname'; print(Pathname.new('$1').relative_path_from(Pathname.new('$(pwd)')))"
  elif command -v python3 >/dev/null 2>&1; then
    python3 -c "import os; print(os.path.relpath('$1'), end='')"
  elif command -v python2 >/dev/null 2>&1; then
    python2 -c \
      "from __future__ import print_function; import os; print(os.path.relpath('$1'), end='')"
  else
    abort "Needs coreutils, python, ruby, or perl."
  fi
}

# Creates an symlink from $DOTFILE_DIR/home/$path_to_file to ~/$path_to_file
# Globals:
#   DOTFILE_DIR
# Arguments:
#   path_to_file : file to install
# Returns:
#   None
install::default() {
  echo "Installing $1"

  [[ "$#" != 1 ]] && abort "Wrong number of arguments."
  [[ "$1" == /* ]] && abort "Cannot use absoulte path."
  [[ ! -e "$DOTFILE_DIR/home/$1" ]] &&
    abort "$DOTFILE_DIR/home/$1 does not exist."

  local dir="$(dirname "$1")"
  local old_pwd="$(pwd)"
  if [[ -n "$dir" ]] && [[ "$dir" != "." ]]; then
    [[ ! -d ~/"$dir" ]] && mkdir -p ~/"$dir"
    cd ~/"$dir"
  else
    cd
  fi

  ln -s "$(relative_path "$DOTFILE_DIR/home/$1")" .
  cd "$old_pwd"
}

main "$@"

echo "Finished installation\n"
echo "Enter following command and Restart a new terminal session:\n\tchsh -s \$(which zsh)\n"
