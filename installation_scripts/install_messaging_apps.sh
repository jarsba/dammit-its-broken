#!/bin/bash

if [[ $EUID -ne 0 ]]; then
	echo "This script must be run as root, run with sudo"
	exit 1
else

	cmd=(dialog --separate-output --checklist "Please select messaging-apps you want to install:" 22 76 16)

	options=(1 "Slack (snap)" off
		2 "Teamviewer" off
		3 "Skype (snap)" off
		4 "Microsoft Teams" off)
	choices=$("${cmd[@]}" "${options[@]}" 2>&1 >/dev/tty)
	clear
	for choice in $choices; do
		case $choice in
		1)
			echo "Installing Slack (snap)"
			snap install slack --classic
			;;

		2)
			echo "Installing Teamviewer"
			wget https://download.teamviewer.com/download/linux/teamviewer_amd64.deb
			apt install ./teamviewer_amd64.deb -y
			rm teamviewer_amd64.deb
			;;

		3)
			echo "Installing Skype (snap)"
			snap install skype --classic
			;;

		4)
			echo "Installing Microsoft Teams"
			wget https://go.microsoft.com/fwlink/p/?linkid=2112886
			apt install ./teams_1.3.00.958_amd64.deb -y
			rm teams_1.3.00.958_amd64.deb
			;;

		esac
	done
fi
