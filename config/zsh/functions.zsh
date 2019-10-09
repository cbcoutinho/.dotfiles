#!/usr/bin/env zsh

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
		CLICOLOR_FORCE=1
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
			*.gz)        gunzip -k $1    ;;
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

    sed -i -E "s/(^colors: \*).*/\1$color/g" ~/.config/alacritty/alacritty.yml
	sed -i -E "s/^(set background=)(\w+)(.*)/\1$(echo $color | sed 's/gruvbox-//')\3/" ~/.config/nvim/colors.vim
}

function workdir {
	# Create a directory based on $1 and current date
    dir="$HOME/datedwork/"$(date "+%Y.%m.%d")"-$1"
    mkdir -p $dir
    cd $dir
}

function pull-git-repos {

	fetch-git-repos ${1-$HOME/Software} true

}

function fetch-git-repos {

	_input=${1:-$HOME/Software}
	_pull=${2:-false}

	_gitdirs=($( fd '\.git$' $_input --type d --hidden --exec dirname {} \; | sort))

	for ii in $_gitdirs; do
		echo && echo $ii
		git -C $ii fetch --all --tags --prune
		git -C $ii submodule update --init --recursive
		if $_pull
		then
			git -C $ii pull --ff-only --recurse-submodules
		fi
	done

}

function awslogin() {

	if [[ $# -eq 1 && ! -z "$AWS_PROFILE" ]]; then
		local AWS_2AUTH_PROFILE=$AWS_PROFILE
		local MFA_TOKEN_CODE=$1
	elif [[ $# -eq 2 ]]; then
		local AWS_2AUTH_PROFILE=$1
		local MFA_TOKEN_CODE=$2
	else # $# -eq 1 and AWS_PROFILE is set
		echo $# $*
		echo "Usage: aws-login [<AWS_PROFILE>] <MFA_TOKEN_CODE>"
		return 1
	fi

	local AWS_USER_PROFILE=carnext-master

	# Get role_arn associated with a profile
	local role=$(rg "$AWS_2AUTH_PROFILE" ~/.aws/config -A 3 | rg 'role_arn' | awk -F= '{print $2}' | tr -d '[:space:]' |  head -1)
	local mfa_serial=$(rg "$AWS_2AUTH_PROFILE" ~/.aws/config -A 3 | rg 'mfa_serial' | awk -F= '{print $2}' | tr -d '[:space:]' |  head -1)

	# 43200 seconds = 12 hrs
	local output=$(aws sts assume-role \
		--profile "$AWS_USER_PROFILE" \
		--role-arn "$role" \
		--serial-number "$mfa_serial" \
		--token-code "$MFA_TOKEN_CODE" \
		--role-session-name "datamesh-session-cli-$(shuf -i 1-100000 -n 1)" \
		--output json | jq -c)

	if [ -z $(echo $output | jq '.Credentials.AccessKeyId') ]
	then
		echo Unable to retrieve access credentials
		return 1
	fi

	export AWS_ACCESS_KEY_ID=$(echo $output | jq -r '.Credentials.AccessKeyId')
	export AWS_SECRET_ACCESS_KEY=$(echo $output | jq -r '.Credentials.SecretAccessKey')
	export AWS_SESSION_TOKEN=$(echo $output | jq -r '.Credentials.SessionToken')
	local Expiration=$(echo $output | jq -r '.Credentials.Expiration')

	aws configure --profile "$AWS_2AUTH_PROFILE" set aws_access_key_id "$AWS_ACCESS_KEY_ID"
	aws configure --profile "$AWS_2AUTH_PROFILE" set aws_secret_access_key "$AWS_SECRET_ACCESS_KEY"
	aws configure --profile "$AWS_2AUTH_PROFILE" set aws_session_token "$AWS_SESSION_TOKEN"
	echo "# Expiration: $Expiration" >> ~/.aws/credentials

	echo "AWS Credentials for '$role' available until: '$Expiration'"

}

function awslogout() {
	set -x
	unset AWS_ACCESS_KEY_ID AWS_SECRET_ACCESS_KEY AWS_SESSION_TOKEN
}

# Shadow git commands
# https://stackoverflow.com/a/39357426/5536001
function git {
	if [[ "$1" == "clean" && "$@" != *"--help"* ]]; then
		shift 1
		command git cl "$@"
	else
		command git "$@"
	fi
}

