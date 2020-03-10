#!/bin/bash

if [[ $EUID -ne 0 ]]; then
    echo "This script must be run as root, run with sudo"
    exit 1
else

    cmd=(dialog --separate-output --checklist "Please select code editor extensions you want to install:" 22 76 16)

    options=(1 "Vscode Debugger For Chrome (msjsdiag)" off
        2 "Vscode Apollo GraphQL (apollographql)" off
        3 "Vscode Better Comments (aaron-bond)" off
        4 "Vscode Docker (ms-azuretools)" off
        5 "Vscode Eslint (dbaeumer)" off
        6 "Vscode Python (ms-python)" off
        7 "Vscode Kite (kiteco)" off
        8 "Vscode Markdown Lint (davidanson)" off
        9 "Vscode Rest Client (humao)" off
        10 "Vscode SVG Viewer (cssho)" off
        11 "Vscode Shell Formatter (foxundermoon)" off
        12 "Vscode Prettier (esbenp)" off
        13 "Vscode Dracula Theme (dracula-theme)" off)
    choices=$("${cmd[@]}" "${options[@]}" 2>&1 >/dev/tty)
    clear
    for choice in $choices; do
        case $choice in

        1)
            echo "Installing Vscode Debugger For Chrome-extension"
            sudo -u $SUDO_USER code --install-extension msjsdiag.debugger-for-chrome
            ;;
        2)
            echo "Installing Vscode Apollo GraphQL-extension"
            sudo -u $SUDO_USER code --install-extension apollographql.vscode-apollo
            ;;
        3)
            echo "Installing Vscode Better Comments-extension"
            sudo -u $SUDO_USER code --install-extension aaron-bond.better-comments
            ;;

        4)
            echo "Installing Vscode Docker-extension"
            sudo -u $SUDO_USER code --install-extension ms-azuretools.vscode-docker
            ;;

        5)
            echo "Installing Vscode Eslint-extension"
            sudo -u $SUDO_USER code --install-extension dbaeumer.vscode-eslint
            ;;

        6)
            echo "Installing Vscode Python-extension"
            sudo -u $SUDO_USER code --install-extension ms-python.python
            ;;

        7)
            echo "Installing Vscode Kite-extension"
            sudo -u $SUDO_USER code --install-extension kiteco.kite
            ;;

        8)
            echo "Installing Vscode Markdown Lint-extension"
            sudo -u $SUDO_USER code --install-extension davidanson.vscode-markdownlint
            ;;

        9)
            echo "Installing Vscode Rest Client-extension"
            sudo -u $SUDO_USER code --install-extension humao.rest-client
            ;;

        10)
            echo "Installing Vscode SVG Viewer-extension"
            sudo -u $SUDO_USER code --install-extension cssho.vscode-svgviewer
            ;;

        11)
            echo "Installing Vscode Shell Formatter-extension"
            sudo -u $SUDO_USER code --install-extension foxundermoon.shell-format
            ;;

        12)
            echo "Installing Vscode Prettier-extension"
            sudo -u $SUDO_USER code --install-extension esbenp.prettier-vscode
            ;;

        13)
            echo "Installing Vscode Dracula Theme"
            sudo -u $SUDO_USER code --install-extension dracula-theme.theme-dracula
            ;;

        esac
    done
fi
