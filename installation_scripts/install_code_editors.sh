#!/bin/bash

if [[ $EUID -ne 0 ]]; then
	echo "This script must be run as root, run with sudo"
	exit 1
else

	cmd=(dialog --separate-output --checklist "Please select code editors you want to install:" 22 76 16)

	options=(1 "Atom (snap)" off
		2 "Pycharm Professional (snap)" off
		3 "IntelliJ IDEA (snap)" off
		4 "Visual Studio Code (snap)" off
		5 "IntelliJ DataGrip (snap)" off
		6 "Sublime Text 3" off
		7 "Vim" off
		8 "Emacs" off
		9 "R with R-studio" off
		10 "IntelliJ Goland (snap)" off)
	choices=$("${cmd[@]}" "${options[@]}" 2>&1 >/dev/tty)
	clear
	for choice in $choices; do
		case $choice in

		1)
			echo "Installing Atom (snap)"
			snap install atom --classic
			;;
		2)
			echo "Installing Pycharm Professional (snap)"
			snap install pycharm-professional --classic
			;;
		3)
			echo "Installing IntelliJ IDEA (snap)"
			snap install intellij-idea-ultimate --classic
			;;
		4)
			echo "Installing Visual Studio Code (snap)"
			snap install --classic code
			;;
		5)
			echo "Installing IntelliJ DataGrip (snap)"
			snap install datagrip --classic
			;;

		6)
			echo "Installing Sublime Text 3"
			curl -fsSL https://download.sublimetext.com/sublimehq-pub.gpg | sudo apt-key add -
			add-apt-repository "deb https://download.sublimetext.com/ apt/stable/"
			apt install sublime-text -y
			;;

		7)
			echo "Installing Vim"
			apt install vim -y
			;;
		8)
			echo "Installing Emacs"
			apt install emacs -y
			;;

		9)
			echo "Installing R with R-studio"
			apt -y install r-base
			wget https://download1.rstudio.org/desktop/bionic/amd64/rstudio-1.3.959-amd64.deb
			apt install ./rstudio-1.3.959-amd64.deb -y
			rm rstudio-1.3.959-amd64.deb
			;;

		10)
			echo "Installing Goland (snap)"
			snap install --classic goland

		esac
	done
fi
