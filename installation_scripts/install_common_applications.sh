#!/bin/bash

if [[ $EUID -ne 0 ]]; then
	echo "This script must be run as root, run with sudo"
	exit 1
else

	cmd=(dialog --separate-output --checklist "Please select common applications you want to install:" 22 76 16)

	options=(1 "Slack" off
		2 "Teamviewer" off
		3 "Skype" off
		4 "Spotify" off
		5 "Gitkraken" off)
	choices=$("${cmd[@]}" "${options[@]}" 2>&1 >/dev/tty)
	clear
	for choice in $choices; do
		case $choice in

		1)
			echo "Installing Slack"
			snap install slack --classic
			;;

		2)
			echo "Installing Teamviewer"
			wget https://download.teamviewer.com/download/linux/teamviewer_amd64.deb
			apt install ./teamviewer_amd64.deb -y
			rm teamviewer_amd64.deb
			;;
		3)
			echo "Installing Skype"
			snap install skype --classic
			;;
		4)
			echo "Installing Spotify"
			snap install spotify
			;;
		5)
			echo "Installing Gitkraken"
			snap install gitkraken
			;;
		esac
	done
fi
