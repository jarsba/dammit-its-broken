#!/bin/bash

if [[ $EUID -ne 0 ]]; then
	echo "This script must be run as root, run with sudo"
	exit 1
else

	cmd=(dialog --separate-output --checklist "Please select OS utils you want to install:" 22 76 16)

	options=(1 "BleachBit" off
		2 "Gparted" off
		3 "Gnome Tweak Tool" off
		4 "Gnome Shell Extentions" off
		5 "Gnome Shell Host Connector" off
		6 "Neofetch" off
		7 "Htop" off
		8 "Flameshot" off
		9 "Speedtest-cli" off)
	choices=$("${cmd[@]}" "${options[@]}" 2>&1 >/dev/tty)
	clear
	for choice in $choices; do
		case $choice in

		1)
			echo "Installing BleachBit"
			apt install bleachbit -y
			;;
		2)
			echo "Installing Gparted"
			apt-get install gparted -y
			;;
		3)
			echo "Installing Gnome Tweak Tool"
			add-apt-repository universe
			apt-get update
			apt install gnome-tweak-tool -y
			;;
		4)
			echo "Installing Gnome Shell Extentions"
			apt install gnome-shell-extensions -y
			;;
		5)
			echo "Installing Gnome Shell Host Connector"
			apt install chrome-gnome-shell -y
			;;
		6)
			echo "Installing Neofetch"
			apt install neofetch -y
			;;
		7)
			echo "Installing Htop"
			apt install htop -y
			;;
		8)
			echo "Installing Flameshot"
			apt install flameshot -y
			;;

		9)
			echo "Installing Speedtest-cli"
			apt install speedtest-cli -y
			;;

		esac
	done
fi
