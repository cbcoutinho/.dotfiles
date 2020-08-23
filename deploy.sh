#!/bin/bash
# This script installs dependencies, replaces all dotfiles with symlinks to
# those in this directory

set -e

# Use GITHUB_WORKSPACE env var if available
dotfiles="${GITHUB_WORKSPACE:-$HOME/Projects/.dotfiles}"

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
mv ~/.zshenv ~/.zshenv.old || echo 'No previous .zshenv found to move'
ln -s $dotfiles/.zshenv ~/.zshenv
mv ~/.profile ~/.profile.old || echo 'No previous .profile found to move'
ln -s $dotfiles/.profile ~/.profile

# Create link gpg config files to homedir
mkdir -p ~/.gnupg
ln -s $dotfiles/.gnupg/gpg.conf ~/.gnupg/gpg.conf
ln -s $dotfiles/.gnupg/gpg-agent.conf ~/.gnupg/gpg-agent.conf
ln -s $dotfiles/.gnupg/sshcontrol ~/.gnupg/sshcontrol

# Node/npm/nvm dot files
ln -s $dotfiles/.nvmrc ~/.nvmrc

# Python
if command -v python3 >/dev/null; then
	python3 -m pip install --user -U virtualenvwrapper
else
	echo 'Python3 not found - skipping virtualenvwrapper'
fi

# Xorg
if [[ $(uname -s) == "Linux" ]]; then
	mv ~/.xinitrc ~/.xinitrc.old || echo 'No previous .xinitrc found'
	ln -s $dotfiles/.xinitrc ~/.xinitrc
fi

# Clojure
echo 'Installing Leiningen'
if [[ $(uname -s) == "Darwin" ]]; then
	brew install leiningen clojure
	brew tap adoptopenjdk/openjdk
	brew cask install adoptopenjdk{8,11,14}
else # Assuming linux
	mkdir -p ~/bin
	curl -L https://raw.githubusercontent.com/technomancy/leiningen/stable/bin/lein > ~/bin/lein
	chmod +x ~/bin/lein
fi

# Ruby
ln -s $dotfiles/.gemrc ~/.gemrc

# Sqlite
ln -s $dotfiles/.sqliterc ~/.sqliterc

# SBT
ln -s $dotfiles/sbt ~/.sbt

# Neovim (plugins)
echo 'Installing neovim'
if [[ $(uname -s) == "Darwin" ]]; then
	brew install nvim
fi
#nvim --headless +PlugUpdate! +qall
