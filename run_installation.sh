#!/bin/bash

if [[ $EUID -ne 0 ]]; then
	echo "This script must be run as root, run with sudo"
	exit 1
else
	DIR="$(cd "$(dirname "$0")" && pwd)"
	INSTALLATION_SCRIPT_DIR="$DIR/installation_scripts"
	SETUP_SCRIPT_DIR="$DIR/setup_scripts"
	RED='\033[0;31m'
	NC='\033[0m' # No Color

	echo -e "Running ${RED}apt update; apt upgrade;${NC} and installing dialog-library for GUI ${RED}apt install dialog -y${NC}?"
	select yn in "Yes" "No"; do
    	    case $yn in
        	Yes ) break;;
        	No ) exit;;
    	    esac
	done

	apt-get update
	apt-get upgrade -y
	apt install dialog -y

	dialog --title "Hello World" --msgbox 'This script is for installing software for Ubuntu 18.04 with Gnome desktop environment!' 12 40
	dialog --title "Last update" --msgbox 'Installing scripts have been updated last time 11.04.2019, if some installation script is broken, please update it and send merge request.' 12 40

	# UPDATE & UPGRADE

	dialog --title "Update & upgrade" --msgbox "Let's update and upgrade our apt, shall we?" 12 40

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
	options=(1 "OS utils 👷" off
		2 "Dev tools 🛠️" off
		3 "Code editors 👨‍💻" off
		4 "Code editors extensions 👨‍💻+💪" off
		5 "Browsers 🌐" off
		6 "Writing tools 🖋️" off
		7 "GTK themes 🌄" off
		8 "Cloud storage clients 💾" off
		9 "Messaging apps 💌" off
		10 "Music apps 🎵" off
		11 "Terminals 🤖" off
		12 "Python tools 🐍" off
		13 "Setup functions 🚀" off)
	choices=$("${cmd[@]}" "${options[@]}" 2>&1 >/dev/tty)
	clear
	for choice in $choices; do
		case $choice in

		1)
			$INSTALLATION_SCRIPT_DIR/install_os_utils.sh
			;;
		2)
			$INSTALLATION_SCRIPT_DIR/install_dev_tools.sh
			;;
		3)
			$INSTALLATION_SCRIPT_DIR/install_code_editors.sh
			;;
		4)
			$INSTALLATION_SCRIPT_DIR/install_code_editor_extensions.sh
			;;
		5)
			$INSTALLATION_SCRIPT_DIR/install_browsers.sh
			;;		
		6)
			$INSTALLATION_SCRIPT_DIR/install_writing_tools.sh
			;;
		7)
			$INSTALLATION_SCRIPT_DIR/install_gtk_themes.sh
			;;
		8)
			$INSTALLATION_SCRIPT_DIR/install_cloud_storage_clients.sh
			;;
		9)
			$INSTALLATION_SCRIPT_DIR/install_messaging_apps.sh
			;;
		10)
			$INSTALLATION_SCRIPT_DIR/install_music_apps.sh
			;;
		11)
			$INSTALLATION_SCRIPT_DIR/install_terminals.sh
			;;
		12)
			$INSTALLATION_SCRIPT_DIR/install_python_tools.sh
			;;
		13)
			$SETUP_SCRIPT_DIR/common_setup_functions.sh
			;;
		esac
	done

	dialog --title "All done" --msgbox "Leave a pull request or issue if you have any comments or suggestions 🐱" 12 40
	clear
fi
