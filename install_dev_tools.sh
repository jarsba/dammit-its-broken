#!/bin/bash

if [[ $EUID -ne 0 ]]; then
   	echo "This script must be run as root" 
   	exit 1
   	
else

	cmd=(dialog --separate-output --checklist "Please select dev tools you want to install:" 22 76 16)
	
	options=(1 "Build Essentials" off
			 2 "Node.js" off
			 3 "Git" off
			 4 "OpenJDK 10/11" off
			 5 "Docker" off
			 6 "Docker Compose" off
			 7 "Python3 pip" off
			 8 "Python dev-tools" off)
	choices=$("${cmd[@]}" "${options[@]}" 2>&1 >/dev/tty)
	clear
	for choice in $choices
	do
	    case $choice in
				
			1)	
				echo "Installing Build Essentials"
				apt install -y build-essential
				;;
				
			2)
				echo "Installing Node.js"
				curl -sL https://deb.nodesource.com/setup_10.x | sudo bash -
				apt install -y nodejs
				;;
			3)
				echo "Installing Git, please configure git later..."
				apt install git -y
				;;
			4)
				echo "Installing OpenJDK 10/11"
				apt install openjdk-11-jdk -y
				;;
			5)
				echo "Installing Docker"
				curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -			
				add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu bionic stable" -y
				apt update
				apt install docker-ce -y
				;;
			6)
				echo "Installing Docker Compose"
				curl -L https://github.com/docker/compose/releases/download/1.24.0/docker-compose-`uname -s`-`uname -m` -o /usr/local/bin/docker-compose
				chmod +x /usr/local/bin/docker-compose
				;;
			7)
				echo "Installing Python3 pip"
				apt install python3-pip -y
				;;
			8)
				echo "Installing Python3 dev-tools"
				apt install python3-dev -y
				;;

	    esac
	done
fi
