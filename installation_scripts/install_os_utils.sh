#!/bin/bash

if [[ $EUID -ne 0 ]]; then
	echo "This script must be run as root, run with sudo"
	exit 1

else

	cmd=(dialog --separate-output --checklist "Please select OS utils you want to install:" 22 76 16)

	options=(1 "BleachBit" off
		2 "Gparted" off
		3 "VLC Media Player" off
		4 "Gnome Tweak Tool" off
		5 "Gnome Shell Extentions" off
		6 "Gnome Shell Host Connector" off
		7 "Neofetch" off
		8 "Htop" off
		9 "Zsh" off
		10 "Terminator" off)
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
			echo "Installing VLC Media Player"
			apt install vlc -y
			;;
		4)
			echo "Installing Gnome Tweak Tool"
			add-apt-repository universe
			apt-get update
			apt install gnome-tweak-tool -y
			;;
		5)
			echo "Installing Gnome Shell Extentions"
			apt install gnome-shell-extensions -y
			;;
		6)
			echo "Installing Gnome Shell Host Connector"
			apt install chrome-gnome-shell -y
			;;
		7)
			echo "Installing Neofetch"
			apt install neofetch -y
			;;
		8)
			echo "Installing Htop"
			apt install htop -y
			;;
		9)
			echo "Installing Zsh"
			sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
			;;
		10)
			echo "Installing Terminator"
			apt-get install terminator -y
			;;
		esac
	done
fi
