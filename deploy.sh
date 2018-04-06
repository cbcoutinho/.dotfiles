#!/usr/bin/env bash
# This script replaces all dotfiles with symlinks to those in this directory

set -e

# Find all files and are not in the .git directory, and do not include the
# README or the deploy.sh script
files="$(find -type f | grep -v '.git' | grep -v 'README.md' | grep -v 'deploy.sh')"

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
      # echo "Is a link! Destroy: $target"
      rm "$target"
    else
      # echo "Is not a link! Move: $target"
      mv "$target" "$target.orig"
    fi
  # else
    # echo "File doesn't exist: $target"
  fi

  echo "Creating link: $target -> $localfile"
  ln -s $localfile $target

done
# fi
