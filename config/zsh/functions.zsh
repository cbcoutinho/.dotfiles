function ls {
	if [[ $(uname -s) == "Linux" ]]; then
		command ls \
			-F \
			-h \
			--color \
			--author \
			--time-style=long-iso \
			-C "$@" \
			| less
	elif [[ $(uname -s) == "Darwin" ]]; then
		export CLICOLOR_FORCE=1
		command ls \
			-F \
			-h \
			-G \
			-C "$@" \
			| less
	fi
}

# -F Append indicator {*,/,=,>,@,|}
# -h With -l and/or -s, print human readable sizes
# --color=always
# --author with -l, print author name
# --time-style=long-iso with -l, show times using ISO style
# -C List entries ($@) in columns
# | less pipe output into less (see .zsh/aliases.zsh for alias)

# extract archives
function extract {
	set -x
	if [ -f $1 ] ; then
		case $1 in
			*.tar.bz2)   tar xvjf $1     ;;
			*.tar.gz)    tar xvzf $1     ;;
			*.tar.xz)    tar xvf $1      ;;
			*.bz2)       bunzip2 $1      ;;
			*.rar)       unrar x $1      ;;
			*.gz)        gunzip $1       ;;
			*.tar)       tar xvf $1      ;;
			*.tbz2)      tar xvjf $1     ;;
			*.tgz)       tar xvzf $1     ;;
			*.zip)       unzip $1 -d `echo $1 | sed 's/\.zip//g'` ;;
			*.Z)         uncompress $1   ;;
			*.7z)        7z x $1         ;;
			*.xz)        xz -d -v $1     ;;
			*)           echo "'$1' cannot be extracted via >extract<" ;;
		esac
	else
		echo "'$1' is not a valid file!"
	fi
}

# pretty-print of some PATH variables
function path {
	echo $PATH | sed 's/:/\
/g'
}

function fpath {
	echo $FPATH | sed 's/:/\
/g'
}

function libpath {
	echo $LD_LIBRARY_PATH | sed 's/:/\
/g'
}

function terminal-scheme {
	# Change the Alacritty color-scheme, options are:
	# 	gruvbox-dark
	# 	gruvbox-light

	# Return with message if no input specified
	readonly color=${1:?"The color scheme must be specified"}

    config_file=~/.config/alacritty/alacritty.yml
    sed -i '' "s/\(^colors: \*\).*/\1$color/g" $config_file
}

function workdir {
	# Create a directory based on $1 and current date
    dir="$HOME/datedwork/"$(date "+%Y.%m.%d")"-$1"
    mkdir -p $dir
    cd $dir
}

function pull-git-repos {

	fetch-git-repos ${1-$HOME/Software} ${2:-2} true

}

function fetch-git-repos {

	_input=${1:-$HOME/Software}
	_depth=${2:-2}
	_pull=${3:-false}

	_gitdirs=($( find $_input -maxdepth $_depth -type d -name '.git' -exec dirname {} \; | sort))

	for ii in $_gitdirs; do
		echo $ii
		git -C $ii fetch --all --tags --prune
		git -C $ii submodule update --init --recursive
		if $_pull
		then
			git -C $ii pull --ff-only --recurse-submodules
		fi
	done

}
