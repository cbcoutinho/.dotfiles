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

test -s ~/.alias && . ~/.alias || true

# Various aliases
source ~/.shrc

# Git Hub autocompletion for bash
if [ -f $HOME/Software/hub/etc/hub.bash_completion.sh ]; then
    . $HOME/Software/hub/etc/hub.bash_completion.sh
fi

# Get the git branch name
parse_git_branch() {
     /usr/bin/git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/ (\1)/'
}

# Export variables
export PROMPT_DIRTRIM=2 # Trims path name to only last 'N' sub-directories
export PS1="\u:[\w]\$(parse_git_branch)\[\033[00m\]\$ "
export PS2="> "

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
