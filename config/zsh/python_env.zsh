# Pip save wheels cache
[ -d "$HOME/.cache/pip/wheelhouse" ] || mkdir -p $HOME/.cache/pip/wheelhouse
export STANDARD_CACHE_DIR="${XDG_CACHE_HOME:-${HOME}/.cache}/pip"
export WHEELHOUSE="${STANDARD_CACHE_DIR}/wheelhouse"
export PIP_FIND_LINKS="file://${WHEELHOUSE}"
export PIP_WHEEL_DIR="${WHEELHOUSE}"

# Poetry dependency manager
[ -d "$HOME/.poetry/bin" ] && export PATH=$HOME/.poetry/bin:$PATH

# IPython directory
export IPYTHONDIR=$HOME/.config/ipython

# Virtualenvwrapper
export WORKON_HOME=~/.local/share/virtualenvs
