# Based on github.com/maximbaz/dotfiles/.zsh/environment.zsh

export EDITOR='nvim'
export VISUAL='nvim'
export DIFFPROG='nvim -d'

# Pass configuration
export PASSWORD_STORE_CHARACTER_SET='a-zA-Z0-9~!@#$%^&*()-_=+[]{};:,.<>?'
export PASSWORD_STORE_GENERATED_LENGTH=40

# Flags using `nproc`
if command -v nproc >/dev/null; then
	export MAKEFLAGS="$MAKEFLAGS -j`nproc`"
	export OMP_NUM_THREADS=`nproc`
	export MOOSE_JOBS=`nproc`
fi

# Compiler defaults to gcc
export FC=gfortran
export CC=gcc
export CXX=g++

export PATH="/usr/sbin:/sbin:$PATH"
# ~/.local/bin already added in ~/.xinitrc
if [[ "$PATH" != *":$HOME/.local/bin:"* ]]; then
	# Add ~/.local/bin to path if not already
	export PATH="$HOME/.local/bin:$PATH"
fi

export LD_LIBRARY_PATH="$HOME/.local/lib:$HOME/.local/lib64:$LD_LIBRARY_PATH"
export MANPATH="$HOME/.local/share/man:$MANPATH"
export CPATH="$HOME/.local/include:$CPATH"

# Dakota directories
DAKOTA_INST_DIR=$HOME/Software/dakota/install
export PATH="$DAKOTA_INST_DIR/bin:$DAKOTA_INST_DIR/share/example/test:$PATH"
export LD_LIBRARY_PATH="$DAKOTA_INST_DIR/lib:$LD_LIBRARY_PATH"
export PYTHONPATH="$DAKOTA_INST_DIR/share/dakota/Python:$PYTHONPATH"

# PETSc
#export PETSC_DIR=/home/chris/Software/petsc/install
#export PETSC_ARCH=""
export PETSC_DIR=/home/chris/Software/petsc/petsc-src
export PETSC_ARCH=arch-linux2-c-debug

# MOOSE
export MOOSE_DIR="$HOME/Software/MOOSE"

# Haskell directory
PATH="$HOME/.cabal/bin":$PATH

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

# Ruby/Gem-related path
if command -v ruby >/dev/null && command -v gem >/dev/null; then
	export PATH="$(ruby -rrubygems -e 'puts Gem.user_dir')/bin:$PATH"
fi

# added by travis gem
[ -f $HOME/.travis/travis.sh ] && source $HOME/.travis/travis.sh

# Pip save wheels cache
[ -d "$HOME/.cache/pip/wheelhouse" ] || mkdir -p $HOME/.cache/pip/wheelhouse
export STANDARD_CACHE_DIR="${XDG_CACHE_HOME:-${HOME}/.cache}/pip"
export WHEELHOUSE="${STANDARD_CACHE_DIR}/wheelhouse"
export PIP_FIND_LINKS="file://${WHEELHOUSE}"
export PIP_WHEEL_DIR="${WHEELHOUSE}"

# Fix PATH, LIBRARY_PATH, LD_LIBRARY_PATH due to possible 'blanks'
export PATH=$(echo $PATH | sed -E -e 's/^:*//' -e 's/:*$//' -e 's/:+/:/g')
export LIBRARY_PATH=$(echo $LIBRARY_PATH | sed -E -e 's/^:*//' -e 's/:*$//' -e 's/:+/:/g')
export LD_LIBRARY_PATH=$(echo $LD_LIBRARY_PATH | sed -E -e 's/^:*//' -e 's/:*$//' -e 's/:+/:/g')

# CMake repository build (need v3.7+ for learn_dg and Fortran submodules)
export CMAKE_PREFIX_PATH="$LD_LIBRARY_PATH"

# RVM configuration
sandbox_init_rvm() {
	if [ -f ~/.rvm/scripts/rvm ]; then
		source ~/.rvm/scripts/rvm
	else
		echo "No rvm found, execute the following to get 'rvm':"
		echo "	curl -sSL https://get.rvm.io | bash -s stable"
		export rvm_ignore_dotfiles=yes
	fi
}

# Node Version Manager (NVM)
sandbox_init_nvm() {
	export NVM_DIR=~/Software/nvm
	[ -s $NVM_DIR/nvm.sh ] && source $NVM_DIR/nvm.sh
}

# Don't load modules unless used
sandbox_hook rvm rvm
sandbox_hook rvm gem
sandbox_hook rvm ruby

sandbox_hook nvm nvm
sandbox_hook nvm npm
sandbox_hook nvm node
sandbox_hook nvm nvim # This is needed for nvim plugins via npm
