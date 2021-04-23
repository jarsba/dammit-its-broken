#!/bin/bash

if [[ $EUID -ne 0 ]]; then
	echo "This script must be run as root, run with sudo"
	exit 1
else
	cmd=(dialog --separate-output --checklist "Please select terminals you want to install:" 22 76 16)

	options=(1 "Zsh and Oh My Zsh" off
		2 "Terminator" off
		3 "Zsh Powerlevel10k-theme" off)
	choices=$("${cmd[@]}" "${options[@]}" 2>&1 >/dev/tty)
	clear
	for choice in $choices; do
		case $choice in

		1)
			echo "Installing Zsh"
			apt install zsh -y
			echo "Installing Oh My Zsh"
			sudo -u $SUDO_USER sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
			;;
		2)
			echo "Installing Terminator"
			apt-get install terminator -y
			;;
		3)
			echo "Installing Zsh Powerlevel10k theme"
			git clone --depth=1 https://github.com/romkatv/powerlevel10k.git $ZSH_CUSTOM/themes/powerlevel10k
			sed -i 's/^ZSH_THEME.*$/ZSH_THEME="powerlevel10k\/powerlevel10k" /' /home/$SUDO_USER/.zshrc
			;;
		esac
	done
fi
