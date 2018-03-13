# we source the general profile here so we dont have to
# reimplement it
setopt nonomatch
source $HOME/.profile
unsetopt nonomatch
# put your own login shell specific configuration below
# this line


# Sudo functions + ~/bin for tumbleweed?
PATH="/usr/sbin:/sbin:$HOME/bin:$HOME/.local/bin":$PATH
LD_LIBRARY_PATH="$HOME/.local/lib:$HOME/.local/lib64":$LD_LIBRARY_PATH
#LD_LIBRARY_PATH="/usr/local/lib64:/usr/local/lib64/openmpi":$LD_LIBRARY_PATH
MANPATH="$HOME/.local/share/man":$MANPATH
CPATH="$HOME/.local/include:/usr/local/include:$CPATH"

# Dakota directories
PATH="$HOME/Software/dakota/install/bin:$HOME/Software/dakota/install/share/example/test":$PATH
LD_LIBRARY_PATH="$HOME/Software/dakota/install/lib":$LD_LIBRARY_PATH
PYTHONPATH="$HOME/Software/dakota/install/share/dakota/Python":$PYTHONPATH

# PETSc
#export PETSC_DIR=/home/chris/Software/petsc/install
#export PETSC_ARCH=""
export PETSC_DIR=/home/chris/Software/petsc/petsc-src
export PETSC_ARCH=arch-linux2-c-debug

# MOOSE
export MOOSE_DIR="$HOME/Software/MOOSE/moose-src"
export MOOSE_JOBS=`nproc`


# Haskell directory
PATH="$HOME/.cabal/bin":$PATH

# Go-related paths
export GOPATH="$HOME/.go"
PATH="$GOPATH/bin":$PATH


# Pip save wheels cache
[ -d "$HOME/.cache/pip/wheelhouse" ] || mkdir -p $HOME/.cache/pip/wheelhouse
export STANDARD_CACHE_DIR="${XDG_CACHE_HOME:-${HOME}/.cache}/pip"
export WHEELHOUSE="${STANDARD_CACHE_DIR}/wheelhouse"
export PIP_FIND_LINKS="file://${WHEELHOUSE}"
export PIP_WHEEL_DIR="${WHEELHOUSE}"

export PATH
export LIBRARY_PATH
export LD_LIBRARY_PATH
export CPATH
export PYTHONPATH
