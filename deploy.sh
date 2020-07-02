#!/bin/bash
# This script installs dependencies, replaces all dotfiles with symlinks to
# those in this directory

set -e

dotfiles=~/Projects/.dotfiles

# Install rust
if [ ! -d ~/.cargo ]; then
	curl https://sh.rustup.rs -sSf | sh -s -- --no-modify-path -v -y
fi

# Install homebrew on mac
if [[ $(uname -s) == "Darwin" ]] && ! command -v brew &> /dev/null
then
	/usr/bin/ruby -e \
		"$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
fi

# Move all contents of current ~/.config directory into config, and set link to
# config directory
if find ~/.config -mindepth 1 -print -quit 2>/dev/null | grep -q .; then
	mv ~/.config/* $dotfiles/config
	rm -rf ~/.config
fi
ln -s $dotfiles/config ~/.config

# Create link zsh env file to homedir
ln -s $dotfiles/.zshenv ~/.zshenv
ln -s $dotfiles/.profile ~/.profile

# Create link gpg config files to homedir
ln -s $dotfiles/.gnupg/gpg.conf ~/.gnupg/gpg.conf
ln -s $dotfiles/.gnupg/gpg-agent.conf ~/.gnupg/gpg-agent.conf
ln -s $dotfiles/.gnupg/sshcontrol ~/.gnupg/sshcontrol

# Node/npm/nvm dot files
ln -s $dotfiles/.nvmrc ~/.nvmrc

# Python
if command -v python3 >/dev/null
then
	python3 -m pip install --user -U virtualenvwrapper
else
	echo 'Python3 not found - skipping virtualenvwrapper'
fi

# Xorg
if [[ $(uname -s) != "Darwin" ]]
then
	ln -s $dotfiles/.xinitrc ~/.xinitrc
fi

# Clojure
echo 'Installing Leiningen'
if [[ $(uname -s) == "Darwin" ]]
then
	brew install leiningen clojure
else
	curl -L https://raw.githubusercontent.com/technomancy/leiningen/stable/bin/lein > ~/bin/lein
	chmod +x ~/bin/lein
fi

# Ruby
ln -s $dotfiles/.gemrc ~/.gemrc

# Sqlite
ln -s $dotfiles/.sqliterc ~/.sqliterc

# Neovim (plugins)
nvim --headless +PlugUpdate! +qall
