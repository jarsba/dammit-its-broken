#!/bin/bash

if [[ $EUID -ne 0 ]]; then
	echo "This script must be run as root, run with sudo"
	exit 1
else

	cmd=(dialog --separate-output --checklist "Please select browsers you want to install:" 22 76 16)

	options=(1 "Google Chrome" off
		2 "Google Chromium" off
		3 "Firefox" off)
	choices=$("${cmd[@]}" "${options[@]}" 2>&1 >/dev/tty)
	clear
	for choice in $choices; do
		case $choice in

		1)
			echo "Installing Google Chrome"
			wget -q -O - https://dl.google.com/linux/linux_signing_key.pub | sudo apt-key add -
			if ! grep -F 'deb [arch=amd64] http://dl.google.com/linux/chrome/deb/ stable main' /etc/apt/sources.list.d/google-chrome.list; then
				sh -c 'echo "deb [arch=amd64] http://dl.google.com/linux/chrome/deb/ stable main" >> /etc/apt/sources.list.d/google-chrome.list'
			fi
			apt-get update
			apt-get install google-chrome-stable -y
			;;
		2)
			echo "Installing Google Chromium"
			apt install chromium-browser chromium-codecs-ffmpeg-extra chromium-chromedriver -y
			;;
		3)
			echo "Installing Firefox"
			apt install firefox -y
			;;
		esac
	done

fi
