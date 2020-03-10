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
            curl -L https://github.com/pyenv/pyenv-installer/raw/master/bin/pyenv-installer | bash
            ;;
        4)
            echo "Installing virtualenv"
            pip3 install virtualenv
            ;;

        5)
            echo "Installing virtualenvwrapper"
            pip3 install virtualenvwrapper
            mkdir $HOME/.virtualenvs
            echo "export VIRTUALENVWRAPPER_PYTHON=/usr/bin/python3" >>$HOME/.$0rc
            echo "export WORKON_HOME=$HOME/.virtualenvs" >>$HOME/.$0rc
            echo "export VIRTUALENVWRAPPER_VIRTUALENV=$HOME/.local/bin/virtualenv" >>$HOME/.$0rc
            source ~/.local/bin/virtualenvwrapper.sh
            echo "Reopen terminal to see effect of virtualenvwrapper"
            ;;
        esac
    done
fi
