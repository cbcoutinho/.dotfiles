#!/bin/bash
# This script installs dependencies, replaces all dotfiles with symlinks to
# those in this directory

set -e

dotfiles=~/Projects/.dotfiles

# Install rust
if [ ! -d ~/.cargo ]; then
	curl https://sh.rustup.rs -sSf | sh -s -- --no-modify-path
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

# Create link gpg config files to homedir
ln -s $dotfiles/.gnupg/gpg.conf ~/.gnupg/gpg.conf
ln -s $dotfiles/.gnupg/gpg-agent.conf ~/.gnupg/gpg-agent.conf
ln -s $dotfiles/.gnupg/sshcontrol ~/.gnupg/sshcontrol

# Git config and ignore files
ln -s $dotfiles/.gitconfig ~/.gitconfig
ln -s $dotfiles/.gitignore_global ~/.gitignore_global

# Python
pip install --user -U virtualenvwrapper

# Xorg
ln -s $dotfiles/.xinitrc ~/.xinitrc

# Clojure
curl -L https://raw.githubusercontent.com/technomancy/leiningen/stable/bin/lein > ~/bin/lein
chmod +x ~/bin/lein

# Ruby
ln -s $dotfiles/.gemrc ~/.gemrc
