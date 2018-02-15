#!/bin/bash

# A simple script to pull all software from git repositories in the
# $HOME/Software directory

for ii in `find $HOME/Software -type d -name '.git' -prune -exec dirname {} \;`; do
echo && echo $ii
git -C $ii pull --recurse-submodules
done
