# PATH assignments
#source ~/.zshrc

#fortune -sa && echo '\n'

# Tmux has trouble accessing the gpg-agent otherwise
#	https://unix.stackexchange.com/a/334326/171562
export GPG_TTY=${TTY}

# Refresh gpg-agent tty in case user switches to an X session
#	https://wiki.archlinux.org/index.php/GnuPG#Configure_pinentry_to_use_the_correct_TTY
#gpg-connect-agent updatestartuptty reloadagent /bye >/dev/null 2>&1
