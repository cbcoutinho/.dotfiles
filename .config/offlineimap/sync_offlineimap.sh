#!/bin/sh

# This script relies on the fact that a gpg-agent is running and has
# output its env-file in ~/.gnupg/gpg-agent.env
# /etc/profile.d/gpg-agent.sh

# # This file sets up a proper GPG daemon on login for all users except
# # the root user. Originally found:
# #	https://unix.stackexchange.com/q/131772/171562
# 
# if [ $EUID -ne 0 ] ; then
#     envfile="$HOME/.gnupg/gpg-agent.env"
#     if [[ -e "$envfile" ]] && kill -0 $(grep GPG_AGENT_INFO "$envfile" | cut -d: -f 2) 2>/dev/null; then
#         eval "$(cat "$envfile")"
#     else
#         eval "$(gpg-agent --daemon --enable-ssh-support --write-env-file "$envfile")"
#     fi
#     export GPG_AGENT_INFO  # the env file does not contain the export statement
#     export SSH_AUTH_SOCK   # enable gpg-agent for ssh
# fi


#source $HOME/.gnupg/gpg-agent.env

# The GPG_AGENT_INFO info isn't exported by gpg-agent above
#export GPG_AGENT_INFO

# Also an option to source the gpg-agent variables, use the following
# in crontab:
#	eval $(cat /home/chris/.gnupg/gpg-agent.env) && export GPG_AGENT_INFO && /home/chris/.config/offlineimap/sync_offlineimap.sh
#
# NOTE: This assumes that gpg-agent was called using the
# `write-env-file` option, which is deprecated in gpg 2.1


# Throw away stdout, send stderr to shell/cron
if [ $(hostname) = 'tumbleweed' ]; then
	offlineimap -a ChrisCoutinho -u syslog >/dev/null & pid1=$!
	offlineimap -a Work -u syslog >/dev/null & pid2=$!

	wait $pid1
	wait $pid2
	#echo "OfflineIMAP - Last execution: $(date)"
else
	offlineimap -a Work -u syslog >/dev/null
fi
