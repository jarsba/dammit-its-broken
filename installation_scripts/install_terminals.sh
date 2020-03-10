apt install vim
apt install emacs

zsh theme

git clone --depth=1 https://github.com/romkatv/powerlevel10k.git $ZSH_CUSTOM/themes/powerlevel10k
sed -i 's/^ZSH_THEME.*$/ZSH_THEME="powerlevel10k\/powerlevel10k" /' .zshrc
