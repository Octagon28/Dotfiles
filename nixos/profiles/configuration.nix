{ config, pkgs, user, inputs, ... }:

{

# General System Settings

    system.stateVersion = "23.11";
    boot.kernelPackages = pkgs.linuxPackages_zen;

# System Configuration

    sound.enable = true;
    nixpkgs.config.allowUnfree = true;
    documentation.nixos.enable = false;
    nix.settings = { 
        substituters = ["https://hyprland.cachix.org"];  
        trusted-public-keys = ["hyprland.cachix.org-1:a7pgxzMz7+chwVL3/pzj6jIBMioiJM7ypFP8PwtkuGc="]; };

# Flakes
    nix = {
        package = pkgs.nixVersions.stable;
        extraOptions = "experimental-features = nix-command flakes";
    };
  
# Storage and Swap

    zramSwap.enable = true;
    swapDevices = [ {
        device = "/var/lib/swapfile";
        size = 4*1024; } ];

# NixGC Settings

    nix.gc = {
        automatic = true;
        persistent = true; 
        options = "-d"; };

# Users 

    users.users.${user} = {
        isNormalUser = true;
        extraGroups = [ "wheel" "audio" "video" "optical" "storage" "networkmanager" "libvirtd" "docker" ];
        initialPassword = "password"; };

# Environment

    environment.binsh = "${pkgs.zsh}/bin/zsh";
    #environment.shells = with pkgs; [zsh];
    virtualisation.libvirtd.enable = true;
    nix.optimise.automatic = true;

    programs.dconf.enable = true;
    programs.light.enable = true;
    
    #Hyprland
    programs.hyprland.enable = true;
    programs.hyprland.package = inputs.hyprland.packages.${pkgs.system}.hyprland;
    virtualisation.docker.enable = true;
    virtualisation.docker.storageDriver = "btrfs";


}
