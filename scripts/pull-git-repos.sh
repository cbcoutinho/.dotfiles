#!/bin/bash

# A simple script to pull all software from git repositories in the
# $HOME/Software directory

# Show lines being run
set -x

for ii in `find $HOME/Software -type d -execdir test -d {}/'.git' \; -prune -print`; do
echo && echo $ii
git -C $ii fetch --all --tags
git -C $ii submodule update --init --recursive
git -C $ii pull --recurse-submodules
done
