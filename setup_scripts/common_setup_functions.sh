#!/bin/bash

if [[ $EUID -ne 0 ]]; then
	echo "This script must be run as root"
	exit 1

else

	cmd=(dialog --separate-output --checklist "Please select common setup functions you want to install:" 22 76 16)

	options=(1 "Generate SSH keys" off
	2 "Remove Ubuntu web-launcher" off
	3 "Docker without sudo" off)

	choices=$("${cmd[@]}" "${options[@]}" 2>&1 >/dev/tty)
	clear
	for choice in $choices; do
		case $choice in

		1)
			echo "Generating SSH keys"
			sudo -u $SUDO_USER mkdir /home/$SUDO_USER/.ssh
			sudo -u $SUDO_USER chmod 700 /home/$SUDO_USER/.ssh
			sudo -u $SUDO_USER ssh-keygen -t rsa -b 4096 -f /home/$SUDO_USER/.ssh/id_rsa
			;;

		2)
			echo "Removing web-laucher"
			apt purge ubuntu-web-launchers
			;;

		3)
			if ! [ -x "$(command -v docker)" ]; then
  				echo 'Error: docker is not installed.' >&2
  				continue
			fi
			echo "Installing Docker without sudo"
			groupadd docker
			usermod -aG docker $SUDO_USER
			newgrp docker
			echo "Testing docker without sudo"
			docker run hello-world
			;;
		
		4)
			echo "Setting up background-image"
			./setup_background.sh
			;;
		esac
	done
fi
