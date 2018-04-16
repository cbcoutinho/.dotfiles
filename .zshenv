# PATH assignments
#source ~/.zshrc

#fortune -sa && echo '\n'

# Refresh gpg-agent tty in case user switches to an X session
#	https://wiki.archlinux.org/index.php/GnuPG#Configure_pinentry_to_use_the_correct_TTY
#gpg-connect-agent updatestartuptty reloadagent /bye >/dev/null 2>&1

# This is the order Zsh files are sourced:
#
# .zshenv: (always)
# .zprofile: [[ -o login ]]
# .zshrc: [[ -o interactive ]]
# .zlogin: [[ -o login ]]
export ZDOTDIR=$HOME/.config/zsh

if [[ $(uname -r) =~ Microsoft$ ]]
then
	# To remove windows paths from Linux path:
	#   https://github.com/Microsoft/WSL/issues/1493#issuecomment-266432827
	export PATH=$(echo $PATH | tr ':' '\n' | grep -v /mnt/ | tr '\n' ':')
fi
