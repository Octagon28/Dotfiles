# Dotfiles

sudo rm -f /etc/nixos/*

cd ~/Documents

git clone https://github.com/Octagon28/Dotfiles.git

sudo cp -r ~/Documents/Dotfiles/nixos/* /etc/nixos/

sudo nixos-generate-config /etc/nixos

sudo rm -f /etc/nixos/profiles/clover/hardware-configuration

sudo cp -r /etc/nixos/hardware-configuration /etc/nixos/profiles/clover/

sudo nixos-rebuild switch --upgrade --flake /etc/nixos/#clover --show-trace --option eval-cache false

