# Based on github.com/maximbaz/dotfiles/.zsh/environment.zsh

if command -v nvim >/dev/null; then
	export EDITOR=$(which nvim)
	export VISUAL=$EDITOR
	export DIFFPROG='nvim -d'
fi

if command -v fd >/dev/null; then
	export FZF_DEFAULT_COMMAND='fd --type f --hidden --follow --exclude .git'
	export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
fi

# Pass configuration
export PASSWORD_STORE_CHARACTER_SET='a-zA-Z0-9~!@#$%^&*()-_=+[]{};:,.<>?'
export PASSWORD_STORE_GENERATED_LENGTH=40

# Flags using `nproc`
if command -v nproc >/dev/null; then
	export MAKEFLAGS="$MAKEFLAGS -j`nproc`"
	export OMP_NUM_THREADS=`nproc`
	export MOOSE_JOBS=`nproc`
fi


#export PATH="/usr/sbin:/sbin:$PATH"
export PATH="$HOME/bin:$PATH"
# ~/.local/bin already added in ~/.xinitrc
if [[ "$PATH" != *":$HOME/.local/bin:"* ]]; then
	# Add ~/.local/bin to path if not already
	export PATH="$HOME/.local/bin:$PATH"
fi

export LD_LIBRARY_PATH="$HOME/.local/lib:$HOME/.local/lib64:$LD_LIBRARY_PATH"
export MANPATH="$HOME/.local/share/man:/usr/local/share/man:$MANPATH"
export CPATH="$HOME/.local/include:$CPATH"

# Dakota directories
export DAKOTA_DIR=/opt/dakota
export PATH="$DAKOTA_DIR/bin:$PATH"
export LD_LIBRARY_PATH="$DAKOTA_DIR/lib:$LD_LIBRARY_PATH"

# PETSc
export PETSC_DIR=/opt/petsc
export SLEPC_DIR=$PETSC_DIR

# P4EST
export P4EST_DIR=/opt/p4est

# MOOSE
export MOOSE_DIR="$HOME/Software/MOOSE"

# Tmux has trouble accessing the gpg-agent otherwise
#	https://unix.stackexchange.com/a/334326/171562
export GPG_TTY=${TTY}

# CUDA libraries on workstation
export CUDA_DIR=/usr/local/cuda-10.0
if [[ -d $CUDA_DIR ]]; then
	export PATH="$CUDA_DIR/bin:$PATH"
	export LD_LIBRARY_PATH="$CUDA_DIR/lib64:$LD_LIBRARY_PATH"
fi

# User/System ruby gems
if command -v ruby >/dev/null && command -v gem >/dev/null; then
	PATH="$(command ruby -e 'puts Gem.user_dir')/bin:$PATH"
fi

# Haskell directory
[[ -d "$HOME/.cabal" ]] && PATH="$HOME/.cabal/bin":$PATH

# Go-related paths
export GOPATH="$HOME/.go"
PATH="$GOPATH/bin":$PATH

# Rust-related env vars
if command -v $HOME/.cargo/bin/rustc > /dev/null 2>&1; then
	export PATH="$HOME/.cargo/bin":$PATH
	# Rust directory
	export LD_LIBRARY_PATH="$(rustc --print sysroot)/lib":$LD_LIBRARY_PATH # For rustfmt
	export RUST_SRC_PATH="$(rustc --print sysroot)/lib/rustlib/src/rust/src" # For racer
fi

# added by travis gem
[ -f $HOME/.travis/travis.sh ] && source $HOME/.travis/travis.sh

# Pip save wheels cache
[ -d "$HOME/.cache/pip/wheelhouse" ] || mkdir -p $HOME/.cache/pip/wheelhouse
export STANDARD_CACHE_DIR="${XDG_CACHE_HOME:-${HOME}/.cache}/pip"
export WHEELHOUSE="${STANDARD_CACHE_DIR}/wheelhouse"
export PIP_FIND_LINKS="file://${WHEELHOUSE}"
export PIP_WHEEL_DIR="${WHEELHOUSE}"

# Python virtualenvwrapper
export WORKON_HOME=~/.local/share/virtualenvs
export VIRTUALENVWRAPPER_PYTHON=$(which python3)
export VIRTUALENVWRAPPER_SCRIPT="$HOME/.local/bin/virtualenvwrapper.sh"
source "$HOME/.local/bin/virtualenvwrapper_lazy.sh"

# IPython directory
export IPYTHONDIR=$HOME/.config/ipython

# Fix PATH, LD_LIBRARY_PATH due to possible 'blanks'
#	https://github.com/google/pulldown-cmark/issues/122
export PATH=$(echo $PATH | sed -E -e 's/^:*//' -e 's/:*$//' -e 's/:+/:/g')
export LD_LIBRARY_PATH=$(echo $LD_LIBRARY_PATH | sed -E -e 's/^:*//' -e 's/:*$//' -e 's/:+/:/g')
export PYTHONPATH=$(echo $PYTHONPATH | sed -E -e 's/^:*//' -e 's/:*$//' -e 's/:+/:/g')
export CPATH=$(echo $CPATH | sed -E -e 's/^:*//' -e 's/:*$//' -e 's/:+/:/g')

# Set LIBRARY_PATH to LD_LIBRARY_PATH if unset (related to issue
# above)
export LIBRARY_PATH=${LIBRARY_PATH:-$LD_LIBRARY_PATH}

# CMake repository build (need v3.7+ for learn_dg and Fortran submodules)
export CMAKE_PREFIX_PATH="$LD_LIBRARY_PATH"

export NOTMUCH_CONFIG=~/.config/notmuch/config

# For clojure/clj CLI tools
export CLJ_CONFIG=~/.config/clojure/
