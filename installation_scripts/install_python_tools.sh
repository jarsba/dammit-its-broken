#!/bin/bash

if [[ $EUID -ne 0 ]]; then
    echo "This script must be run as root, run with sudo"
    exit 1
else

    cmd=(dialog --separate-output --checklist "Please select python tools you want to install:" 22 76 16)

    options=(1 "Python3 pip" off
        2 "Python3 dev-tools" off
        3 "Pyenv" off
        4 "Virtualenv" off
        5 "Virtualenvwrapper" off)
    choices=$("${cmd[@]}" "${options[@]}" 2>&1 >/dev/tty)
    clear
    for choice in $choices; do
        case $choice in

        1)
            echo "Installing Python3 pip"
            apt install python3-pip -y
            ;;
        2)
            echo "Installing Python3 dev-tools"
            apt install python3-dev -y
            ;;
        3)
            echo "Installing pyenv"
            sudo -u $SUDO_USER curl -L https://github.com/pyenv/pyenv-installer/raw/master/bin/pyenv-installer | sudo -u $SUDO_USER bash
            ;;
        4)
            echo "Installing virtualenv"
            sudo -u $SUDO_USER pip3 install virtualenv
            ;;

        5)
            echo "Installing virtualenvwrapper"
            sudo -u $SUDO_USER pip3 install virtualenvwrapper
            mkdir /home/$SUDO_USER/.virtualenvs
            echo "export VIRTUALENVWRAPPER_PYTHON=/usr/bin/python3" >> /home/$SUDO_USER/.$0rc
            echo "export WORKON_HOME=/home/$SUDO_USER/.virtualenvs" >> /home/$SUDO_USER/.$0rc
            echo "export VIRTUALENVWRAPPER_VIRTUALENV=/home/$SUDO_USER/.local/bin/virtualenv" >> /home/$SUDO_USER/.$0rc
            source ~/.local/bin/virtualenvwrapper.sh
            echo "Reopen terminal to see effect of virtualenvwrapper"
            ;;
        esac
    done
fi
