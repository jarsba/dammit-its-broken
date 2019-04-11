#!/bin/bash

if [[ $EUID -ne 0 ]]; then
   	echo "This script must be run as root" 
   	exit 1
   	
else

	cmd=(dialog --separate-output --checklist "Please select common setup functions you want to install:" 22 76 16)
	
	options=(1 "Generate SSH keys" off)
	
	choices=$("${cmd[@]}" "${options[@]}" 2>&1 >/dev/tty)
	clear
	for choice in $choices
	do
	    case $choice in
				
			1)
				echo "Generating SSH keys"
				ssh-keygen -t rsa -b 4096
				;;

	    esac
	done
fi
