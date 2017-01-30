# Sample .bashrc for SuSE Linux
# Copyright (c) SuSE GmbH Nuernberg

# There are 3 different types of shells in bash: the login shell, normal shell
# and interactive shell. Login shells read ~/.profile and interactive shells
# read ~/.bashrc; in our setup, /etc/profile sources ~/.bashrc - thus all
# settings made here will also take effect in a login shell.
#
# NOTE: It is recommended to make language settings in ~/.profile rather than
# here, since multilingual X sessions would not work properly if LANG is over-
# ridden in every subshell.

# Some applications read the EDITOR variable to determine your favourite text
# editor. So uncomment the line below and enter the editor of your choice :-)
#export EDITOR=/usr/bin/vim
#export EDITOR=/usr/bin/mcedit

# For some news readers it makes sense to specify the NEWSSERVER variable here
#export NEWSSERVER=your.news.server

# If you want to use a Palm device with Linux, uncomment the two lines below.
# For some (older) Palm Pilots, you might need to set a lower baud rate
# e.g. 57600 or 38400; lowest is 9600 (very slow!)
#
#export PILOTPORT=/dev/pilot
#export PILOTRATE=115200

test -s ~/.alias && . ~/.alias || true

# Various aliases
alias ll="ls -l --group-directories-first"
alias git=hub

# OpenFOAM Aliases
alias ofdev="source $HOME/OpenFOAM/OpenFOAM-dev/etc/bashrc $FOAM_SETTINGS"
alias of4x="source $HOME/OpenFOAM/OpenFOAM-4.x/etc/bashrc $FOAM_SETTINGS"
alias of30x="source $HOME/OpenFOAM/OpenFOAM-3.0.x/etc/bashrc $FOAM_SETTINGS"

# Python path
PATH="$HOME/anaconda3/bin:$PATH"
PYTHONPATH="$HOME/projects/":$PYTHONPATH

# added by travis gem
[ -f $HOME/.travis/travis.sh ] && source $HOME/.travis/travis.sh

# Haskel executables
PATH="$HOME/.local/bin":$PATH

# Rust directory
PATH="$HOME/.cargo/bin:$PATH"

# Git Hub autocompletion for bash
if [ -f $HOME/Software/hub/etc/hub.bash_completion.sh ]; then
    . $HOME/Software/hub/etc/hub.bash_completion.sh
fi

# Export variables
export PS1="\u:[\w]\$ \[$(tput sgr0)\]"
export PS2="> "
export PATH
export PYTHONPATH



### PETSC
# export PETSC_DIR="/usr/lib64/mpi/gcc/openmpi/lib64/petsc/3.4.3"
# export PETSC_ARCH="linux-gnu-c-opt"
export PETSC_DIR="$HOME/Software/petsc/petsc-3.5.4"
export PETSC_ARCH="arch-linux2-c-debug"

### DEALII
# export DEAL_II_DIR="$HOME/Software/dealii/build"
# export DEAL_II_DIR="$HOME/Software/dealii/build2"

### Trilinos
export TRILINOS_DIR="$HOME/Software/Trilinos/build/INSTALL"

### P4EST
export P4EST_DIR="$HOME/Software/p4est/p4est-0.3.4.1"
# export P4EST_DIR="$HOME/Software/p4est/p4est-0.3.4.1/DEBUG"
# export P4EST_DIR="$HOME/Software/p4est/p4est-0.3.4.1/FAST"
# export P4EST_DIR="$HOME/Software/p4est/p4est-0.3.4.2"
# export P4EST_DIR="$HOME/Software/p4est/p4est-0.3.4.2/DEBUG"
# export P4EST_DIR="$HOME/Software/p4est/p4est-0.3.4.2/FAST"
# export P4EST_DIR="$HOME/Software/p4est/p4est-1.0"
# export P4EST_DIR="$HOME/Software/p4est/p4est-1.0/DEBUG"
# export P4EST_DIR="$HOME/Software/p4est/p4est-1.0/FAST"
# export P4EST_DIR="$HOME/Software/p4est/p4est-1.1"
# export P4EST_DIR="$HOME/Software/p4est/p4est-1.1/DEBUG"
# export P4EST_DIR="$HOME/Software/p4est/p4est-1.1/FAST"
