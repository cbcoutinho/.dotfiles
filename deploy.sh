#!/bin/bash
# This script replaces all dotfiles with symlinks to those in this directory

set -e

files="$(find -type f | grep -v '.git' | grep -v 'README.md' | grep -v 'deploy.sh')"
# echo $files

for file in $files
do
  localfile="$(pwd)/$file"
  target="$HOME/$file"
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
  # echo $localfile
  # echo $target

  ln -s $localfile $target

done
# fi
