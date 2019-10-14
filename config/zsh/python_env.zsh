# Pip save wheels cache
[ -d "$HOME/.cache/pip/wheelhouse" ] || mkdir -p $HOME/.cache/pip/wheelhouse
export STANDARD_CACHE_DIR="${XDG_CACHE_HOME:-${HOME}/.cache}/pip"
export WHEELHOUSE="${STANDARD_CACHE_DIR}/wheelhouse"
export PIP_FIND_LINKS="file://${WHEELHOUSE}"
export PIP_WHEEL_DIR="${WHEELHOUSE}"

# Poetry dependency manager
[ -d "$HOME/.poetry/bin" ] && export PATH=$HOME/.poetry/bin:$PATH

# Python virtualenvwrapper
USER_BASE=$(python3 -c 'import site; print(site.USER_BASE)')
export WORKON_HOME=~/.local/share/virtualenvs
export VIRTUALENVWRAPPER_PYTHON=$(which python3)
export VIRTUALENVWRAPPER_SCRIPT="$USER_BASE/bin/virtualenvwrapper.sh"
export PATH="$USER_BASE/bin:$PATH"

# NOTE: This assumes that virtualenvwrapper is installed
source "$USER_BASE/bin/virtualenvwrapper_lazy.sh"

# IPython directory
export IPYTHONDIR=$HOME/.config/ipython

# Pip zsh completions are already saved in $ZDOTDIR/.zfunc/_pip
# This line associates the completions with pip3 as well if available
if command -v pip3 >/dev/null; then
	compctl -K _pip_completion pip3
fi

# Use pyenv to handle python in interactive shells
if command -v pyenv >/dev/null; then
	eval "$(pyenv init -)"
fi
