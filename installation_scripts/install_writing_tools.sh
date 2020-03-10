#!/bin/bash

if [[ $EUID -ne 0 ]]; then
	echo "This script must be run as root, run with sudo"
	exit 1
else

	cmd=(dialog --separate-output --checklist "Please select writing tools you want to install:" 22 76 16)
	
	options=(1 "Typora" off
		2 "Notable (snap)" off
		3 "Tusk (Evernote client) (snap)" off)
	choices=$("${cmd[@]}" "${options[@]}" 2>&1 >/dev/tty)
	clear
	for choice in $choices; do
		case $choice in

		1)
			echo "Installing Typora"
			wget -qO - https://typora.io/linux/public-key.asc | sudo apt-key add -
			add-apt-repository 'deb https://typora.io/linux ./' -y
			apt-get update
			apt-get install typora -y
			;;
		2)
			echo "Installing Notable"
			snap install notable
			;;

		3)
			echo "Installing Tusk"
			snap install tusk
			;;
		esac
	done
fi
