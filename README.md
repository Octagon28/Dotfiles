# Dotfiles

sudo rm -f /etc/nixos/*

cd ~/Documents

git clone https://github.com/Octagon28/Dotfiles.git

sudo cp -r ~/Documents/Dotfiles/nixos/* /etc/nixos/

sudo nixos-rebuild switch --upgrade --flake /etc/nixos/#clover --show-trace --option eval-cache false
