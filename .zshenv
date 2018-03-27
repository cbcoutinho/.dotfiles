# PATH assignments
#source ~/.zshrc

#fortune -sa && echo '\n'

# Tmux has trouble accessing the gpg-agent otherwise
#	https://unix.stackexchange.com/a/334326/171562
export GPG_TTY=${TTY}
