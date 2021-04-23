#!/bin/bash

if [[ $EUID -ne 0 ]]; then
	echo "This script must be run as root"
	exit 1

else

	DIR="$(cd "$(dirname "$0")" && pwd)"
	cmd=(dialog --separate-output --checklist "Please select common setup functions you want to install:" 22 76 16)

	options=(1 "Nina Geometrieva Space-background" off)

	choices=$("${cmd[@]}" "${options[@]}" 2>&1 >/dev/tty)
	clear
	for choice in $choices; do
		case $choice in

		1)
			echo "Setting background to Nina Geometrieva's space-image"
			gsettings set org.gnome.desktop.background picture-uri file:///$DIR/background_images/nina_geometrieva_space.jpeg
			;;
	
		esac
	done
fi
