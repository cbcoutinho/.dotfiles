#!/bin/bash

if [ -f /usr/share/tmux/powerline.conf ]; then
	source /usr/share/tmux/powerline.conf
else
	echo "Powerline config file not found"
fi
