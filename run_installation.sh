#!/bin/bash

if [[ $EUID -ne 0 ]]; then
   	echo "This script must be run as root" 
   	exit 1
else
	
	DIR="$(cd "$(dirname "$0")" && pwd)"

	dialog --title "Hello World" --msgbox 'This script is for installing software for Ubuntu 18.04 with Gnome desktop environment!' 12 40
	dialog --title "Last update" --msgbox 'Installing scripts have been updated last time 11.04.2019, if some installation script is broken, please update it and send merge request.' 12 40
	
	# UPDATE & UPGRADE 
	
	dialog --title "Update & upgrade" --msgbox "Let's update and upgrade our apt, shall we?" 12 40
	
	apt-get update && sudo apt-get upgrade -y

	dialog --title "Necessary tools" --msgbox "Installing utilities for software installation. We will install following tools:\n
	- wget\n
	- curl\n
	- snapd\n
	- software-properties-common\n
	- apt-transport-https\n
	- ca-certificates\n
	- gdebi" 15 40
	sudo apt-get install dialog wget curl snapd software-properties-common apt-transport-https ca-certificates gdebi -y
	PATH=$PATH:/snap/bin
	
	cmd=(dialog --separate-output --checklist "Please select software you want to install:" 22 76 16)
	
	options=(1 "Browsers" off
			 2 "Code editors" off
			 3 "Dev tools" off
			 4 "OS utils" off
			 5 "Common applications" off
			 6 "Writing tools" off
			 7 "GTK themes" off
			 8 "Cloud storage clients" off)
	choices=$("${cmd[@]}" "${options[@]}" 2>&1 >/dev/tty)
	clear
	for choice in $choices
	do
	    case $choice in
	    
        	1)
				$DIR/install_browsers.sh
				;;
			2) 
				$DIR/install_code_editors.sh
				;;
			3) 
				$DIR/install_dev_tools.sh
				;;
			4)
				$DIR/install_os_utils.sh
				;;
			4)
				$DIR/install_common_applications.sh
				;;
			5)
				$DIR/install_writing_tools.sh
				;;
			6)
				$DIR/install_gtk_themes.sh
				;;
			7)
				$DIR/run_common_setup_functions.sh
				;;
			8)	
				$DIR/install_cloud_storage_clients.sh
				;;
				
	    esac
	done
fi
