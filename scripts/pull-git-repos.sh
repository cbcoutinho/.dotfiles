#!/bin/bash

for ii in `find $HOME/Software -type d -name '.git' -prune -exec dirname {} \;`; do
echo && echo $ii
git -C $ii pull --recurse-submodules
done
