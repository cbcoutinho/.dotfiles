# Based on github.com/maximbaz/dotfiles/.zsh/environment.zsh

# Prepend bin and sudo bin to PATH
export PATH="/sbin:/usr/sbin:/usr/local/sbin:$HOME/bin:$HOME/.local/bin:$PATH"

# Add mssql-tools to path if exists
if [[ -d /opt/mssql-tools/bin ]]; then
	export PATH="/opt/mssql-tools/bin":$PATH
fi

# Add CUDA to path if exists
if [[ -d ${CUDA_DIR:-/usr/local/cuda} ]]; then
	export PATH="$CUDA_DIR/bin:$PATH"
	export LD_LIBRARY_PATH="$CUDA_DIR/lib64:$LD_LIBRARY_PATH"
fi

[[ -d "$HOME/.local/lib" ]] && export LD_LIBRARY_PATH="$HOME/.local/lib:$LD_LIBRARY_PATH"
[[ -d "$HOME/.local/lib64" ]] && export LD_LIBRARY_PATH="$HOME/.local/lib64:$LD_LIBRARY_PATH"

[[ -d "/usr/local/share/man:$MANPATH" ]] && export MANPATH="/usr/local/share/man:$MANPATH"
[[ -d "$HOME/.local/share/man" ]] && export MANPATH="$HOME/.local/share/man:$MANPATH"
[[ -d "$HOME/.local/include" ]] && export CPATH="$HOME/.local/include:$CPATH"

# Add PETSc to path if exists
if [[ -d ${PETSC_DIR:-/opt/petsc} ]]; then
	export PETSC_DIR
	export SLEPC_DIR=$PETSC_DIR
fi

# P4EST
if [[ -d ${P4EST_DIR:-/opt/p4est} ]]; then
	export P4EST_DIR
fi

# Pass configuration
export PASSWORD_STORE_CHARACTER_SET='a-zA-Z0-9~!@#$%^&*()-_=+[]{};:,.<>?'
export PASSWORD_STORE_GENERATED_LENGTH=40

# MOOSE
if [[ -d ${MOOSE_DIR:-$HOME/Software/moose} ]]; then
	export MOOSE_DIR
fi

# ParaView
if [[ -d /opt/paraview ]]; then
	PATH="/opt/paraview/bin:$PATH"
	LD_LIBRARY_PATH="/opt/paraview/lib:$LD_LIBRARY_PATH"
fi

# Tmux has trouble accessing the gpg-agent otherwise
#	https://unix.stackexchange.com/a/334326/171562
export GPG_TTY=${TTY}

# Haskell directory
[[ -d "$HOME/.cabal" ]] && PATH="$HOME/.cabal/bin":$PATH

# Go-related paths
export GOPATH="$HOME/.go"
export PATH="$GOPATH/bin":$PATH

# .Net-related path
if [[ -d $HOME/.dotnet ]]; then
	export PATH="$HOME/.dotnet/tools":$PATH
fi

# Rust-related env vars
if [[ -d $HOME/.cargo ]]; then
	export PATH="$HOME/.cargo/bin":$PATH
	export LD_LIBRARY_PATH="$(rustc --print sysroot)/lib":$LD_LIBRARY_PATH # For rustfmt
	export RUST_SRC_PATH="$(rustc --print sysroot)/lib/rustlib/src/rust/src" # For racer
fi

# If `fd` avaiable, set env vars
if command -v fd >/dev/null; then
	export FZF_DEFAULT_COMMAND='fd --type f --hidden --follow --exclude .git'
	export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
fi

# Set default editor to `vim`
if command -v nvim >/dev/null; then
	export EDITOR=nvim
	export VISUAL=$EDITOR
	export DIFFPROG='nvim -d'
	export PAGER=less
fi

# Flags using `nproc`
if command -v nproc >/dev/null; then
	#export MAKEFLAGS="$MAKEFLAGS -j`nproc`"
	export OMP_NUM_THREADS=`nproc`
	export MOOSE_JOBS=`nproc`
fi

# added by travis gem
[ -f $HOME/.travis/travis.sh ] && source $HOME/.travis/travis.sh

# Python-related vars
source $ZDOTDIR/python_env.zsh

# MacTex doesn't update PATH
if [[ $(uname -s) == "Darwin" ]] then
	export PATH="/Library/Tex/texbin:$PATH"
fi

# Fix PATH, LD_LIBRARY_PATH due to possible 'blanks'
#	https://github.com/google/pulldown-cmark/issues/122
export PATH=$(echo $PATH | sed -E -e 's/^:*//' -e 's/:*$//' -e 's/:+/:/g')
export LD_LIBRARY_PATH=$(echo $LD_LIBRARY_PATH | sed -E -e 's/^:*//' -e 's/:*$//' -e 's/:+/:/g')
export CPATH=$(echo $CPATH | sed -E -e 's/^:*//' -e 's/:*$//' -e 's/:+/:/g')

# Set LIBRARY_PATH to LD_LIBRARY_PATH if unset (related to issue above)
export LIBRARY_PATH=${LIBRARY_PATH:-$LD_LIBRARY_PATH}

# CMake repository build (need v3.7+ for learn_dg and Fortran submodules)
export CMAKE_PREFIX_PATH="$LD_LIBRARY_PATH"

# Notmuch
export NOTMUCH_CONFIG=~/.config/notmuch/config

# For clojure/clj CLI tools
export CLJ_CONFIG=~/.config/clojure

# Leiningen directory
export LEIN_HOME=$HOME/.config/lein

# Amazon Web Services (AWS)
export AWS_DEFAULT_REGION=eu-west-1
export AWS_DEFAULT_OUTPUT=json
export AWS_PAGER=

export AWS_VAULT_BACKEND=pass
export AWS_VAULT_PASS_PREFIX=aws-vault

if [[ -d "${CONFLUENT_HOME:=/opt/confluent-6.0.0}" ]]; then
	export CONFLUENT_HOME #=/opt/confluent-6.0.0
	export PATH=$CONFLUENT_HOME/bin:$PATH
elif command -v brew >/dev/null && command -v confluent >/dev/null; then
	export CONFLUENT_HOME=$(brew --prefix confluent-platform)/libexec
fi

if command -v ruby >/dev/null && command -v gem >/dev/null; then
    PATH="$(ruby -r rubygems -e 'puts Gem.user_dir')/bin:$PATH"
fi
