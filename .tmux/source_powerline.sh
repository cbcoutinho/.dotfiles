#!/bin/bash

if [ -f /usr/share/tmux/powerline.conf ]; then
	tmux source-file /usr/share/tmux/powerline.conf
else
	echo "Powerline config file not found"
fi
