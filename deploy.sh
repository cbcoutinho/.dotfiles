#!/bin/bash
# This script replaces all dotfiles with symlinks to those in this directory

set -e

# If .atom directory exists...
if [ -d "$HOME/.atom" ]; then

  for file in $(ls .atom/)
  do
    localfile="$(pwd)/.atom/$file"
    target="$HOME/.atom/$file"
    # echo $localfile
    # echo $target

    # If target file already exists, delete or move it...
    if [ -f "$target" ]; then

      # If file is a symlink, delete it, otherwise move it
      if [ -L "$target" ]; then
        echo "Is a link! Destroy"
        rm "$target"
      else
        echo "Is not a link! Move!"
        mv "$target" "$target.orig"
      fi

    fi

    ln -s $localfile $target

  done
fi
