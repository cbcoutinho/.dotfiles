# NOTE: cannot comment inside bash functions, so 'execute' them instead
function ls {
	command ls \
		-F \
		-h \
		-G \
		-C "$@" \
		| less
}
export CLICOLOR_FORCE=1

# -F Append indicator {*,/,=,>,@,|}
# -h With -l and/or -s, print human readable sizes
# --color=always
# --author with -l, print author name
# --time-style=long-iso with -l, show times using ISO style
# -C List entries ($@) in columns
# | less pipe output into less (see .zsh/aliases.zsh for alias)

# extract archives
function extract()
{
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
#alias path="echo -e ${PATH//:/\\\n}"
#alias libpath="echo -e ${LD_LIBRARY_PATH//:/\\\n}"
function path () {
	echo $PATH | sed 's/:/\
/g'
}

function libpath () {
	echo $LD_LIBRARY_PATH | sed 's/:/\
/g'
}

# Terminal color scheme
function terminal-scheme() {
    config_file=~/.config/alacritty/alacritty.yml
    sed -i "s/\(^colors: \*\).*/\1$1/g" $config_file
}

workdir() {
    dir="$HOME/datedwork/"$(date "+%Y.%m.%d")"-$1"
    mkdir -p $dir
    cd $dir
}
