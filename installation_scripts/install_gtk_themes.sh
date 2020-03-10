#!/bin/bash

if [[ $EUID -ne 0 ]]; then
	echo "This script must be run as root, run with sudo"
	exit 1

else

	cmd=(dialog --separate-output --checklist "Please select GTK themes you want to install:" 22 76 16)

	options=(1 "Paper Icons" off
		2 "Arc Theme" off
		3 "Arc Icons" off
		4 "Numic Theme" off
		5 "Numic Icons" off)
	choices=$("${cmd[@]}" "${options[@]}" 2>&1 >/dev/tty)
	clear
	for choice in $choices; do
		case $choice in

		1)
			echo "Installing Paper Icons"
			add-apt-repository -u ppa:snwh/ppa -y
			apt-get update
			apt-get install paper-icon-theme -y
			;;
		2)
			echo "Installing Arc Theme"
			apt install arc-theme -y
			;;
		3)
			echo "Installing Arc Icons"
			add-apt-repository ppa:noobslab/icons -y
			apt-get update
			apt-get install arc-icons -y
			;;
		4)
			echo "Installing Numic Theme"
			apt install numix-gtk-theme -y
			;;
		5)
			echo "Installing Numic Icons"
			apt install numix-gtk-theme numix-icon-theme -y
			;;

		esac
	done
fi
