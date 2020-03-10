#!/bin/bash

if [[ $EUID -ne 0 ]]; then
	echo "This script must be run as root, run with sudo"
	exit 1
else

	cmd=(dialog --separate-output --checklist "Please select music-apps you want to install:" 22 76 16)

	options=(1 "Spotify (snap)" off
		2 "VLC" off)
	choices=$("${cmd[@]}" "${options[@]}" 2>&1 >/dev/tty)
	clear
	for choice in $choices; do
		case $choice in

		1)
			echo "Installing Spotify (snap)"
			snap install spotify
			;;
		2)
			echo "Installing VLC Media Player"
			apt install vlc -y
			;;

		esac
	done
fi
