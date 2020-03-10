#!/bin/bash

if [[ $EUID -ne 0 ]]; then
	echo "This script must be run as root, run with sudo"
	exit 1
else
	DIR="$(cd "$(dirname "$0")" && pwd)"
	INSTALLATION_SCRIPT_DIR="$DIR/installation_scripts"
	SETUP_SCRIPT_DIR="$DIR/setup_scripts"

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
	options=(1 "Browsers 🌐" off
		2 "Code editors 👨‍💻" off
		3 "Dev tools 🧰" off
		4 "OS utils 🔨" off
		5 "Common applications" off
		6 "Writing tools 🖋️" off
		7 "GTK themes 🌄" off
		8 "Cloud storage clients 💾" off
		9 "Setup functions" off)
	choices=$("${cmd[@]}" "${options[@]}" 2>&1 >/dev/tty)
	#clear
	for choice in $choices; do
		case $choice in

		1)
			$INSTALLATION_SCRIPT_DIR/install_browsers.sh
			;;
		2)
			$INSTALLATION_SCRIPT_DIR/install_code_editors.sh
			;;
		3)
			$INSTALLATION_SCRIPT_DIR/install_dev_tools.sh
			;;
		4)
			$INSTALLATION_SCRIPT_DIR/install_os_utils.sh
			;;
		4)
			$INSTALLATION_SCRIPT_DIR/install_common_applications.sh
			;;
		5)
			$INSTALLATION_SCRIPT_DIR/install_writing_tools.sh
			;;
		6)
			$INSTALLATION_SCRIPT_DIR/install_gtk_themes.sh
			;;
		7)
			$INSTALLATION_SCRIPT_DIR/install_cloud_storage_clients.sh
			;;
		9)
			$SETUP_SCRIPT_DIR/common_setup_functions.sh
			;;
		esac
	done

	dialog --title "All done" --msgbox "Leave a pull request or issue if you have any comments or suggestions 🐱" 12 40

fi
