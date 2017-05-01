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
eval "$(hub alias -s)"

# OpenFOAM Aliases
alias ofdev="source $HOME/OpenFOAM/OpenFOAM-dev/etc/bashrc $FOAM_SETTINGS"
alias of4x="source $HOME/OpenFOAM/OpenFOAM-4.x/etc/bashrc $FOAM_SETTINGS"
alias of30x="source $HOME/OpenFOAM/OpenFOAM-3.0.x/etc/bashrc $FOAM_SETTINGS"

# Python path
PATH="$HOME/anaconda3/bin:$PATH"
PYTHONPATH="$HOME/Projects/":$PYTHONPATH

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

# GCC development directories
PATH="$HOME/Software/gcc/install/bin/":$PATH
LIBRARY_PATH="$HOME/Software/gcc/install/lib64/gcc/x86_64-pc-linux-gnu/lib64/":$LIBRARY_PATH
LD_LIBRARY_PATH="$HOME/Software/gcc/install/lib64/gcc/x86_64-pc-linux-gnu/7.0.1/":$LD_LIBRARY_PATH

# Boost development directories
# LIBRARY_PATH="$HOME/Software/boost/install/":$LIBRARY_PATH

# Dakota directories
PATH="$HOME/Software/dakota/install/bin":$PATH
LD_LIBRARY_PATH="$HOME/Software/dakota/install/lib":"$HOME/Software/dakota/install/lib":$LD_LIBRARY_PATH
PYTHONPATH="$HOME/Software/dakota/install/share/dakota/interfaces/":$PYTHONPATH

# CMake repository build (need v3.7+ for learn_dg)
PATH="$HOME/Software/cmake/bin/":$PATH

# OpenMPI directory
PATH="$HOME/Software/openmpi/install/bin":$PATH

# HDF5 directory
PATH="$HOME/Software/hdf5/install/bin/":$PATH
LD_LIBRARY_PATH="$HOME/Software/hdf5/install/lib64":$LD_LIBRARY_PATH

# CUDA directory
PATH="/usr/local/cuda/bin":$PATH
LIBRARY_PATH="/usr/local/cuda/lib64":$LIBRARY_PATH

# CMAKE directory
PATH="$HOME/Software/cmake/install/bin/":$PATH

# Node Version Manager (NVM)
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"
[[ -r $NVM_DIR/bash_completion ]] && . $NVM_DIR/bash_completion

# Export variables
export PS1="\u:[\w]\$ \[$(tput sgr0)\]"
export PS2="> "
export PATH
export LIBRARY_PATH
export LD_LIBRARY_PATH
export PYTHONPATH

# Creates a log file of all commands used per day. Must create ~/.logs/ first
export PROMPT_COMMAND='if [ "$(id -u)" -ne 0 ]; then echo "$(date "+%Y-%m-%d.%H:%M:%S") $(pwd) $(history 1)" >> ~/.logs/bash-history-$(date "+%Y-%m-%d").log; fi'


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
