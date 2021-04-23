#!/bin/bash

if [[ $EUID -ne 0 ]]; then
	echo "This script must be run as root, run with sudo"
	exit 1
else

	cmd=(dialog --separate-output --checklist "Please select cloud storage clients you want to install:" 22 76 16)

	options=(1 "Dropbox" off)
	choices=$("${cmd[@]}" "${options[@]}" 2>&1 >/dev/tty)
	clear
	for choice in $choices; do
		case $choice in

		1)
			echo "Installing Dropbox"
			wget -O dropbox_2020.03.04_amd64.deb https://www.dropbox.com/download?dl=packages/ubuntu/dropbox_2020.03.04_amd64.deb
			apt install ./dropbox_2020.03.04_amd64.deb -y
			rm dropbox_2020.03.04_amd64.deb
			;;

		esac
	done
fi
