{ pkgs, ... }:

{
  home.packages = with pkgs; [

# Development

    cmake
    git
    gnat13

# Terminal Applications

    btop
    clamav
    coreutils-full
    ffmpeg_6-full
    findutils
    grc
    killall
    light
    mpv
    neofetch
    ncmpcpp
    newsboat
    perl538Packages.WWWYoutubeViewer
    ripgrep
    rm-improved
    slurp
    swww
    termshark
    thefuck
    translate-shell
    unar
    wikicurses

# GUI Applications
    
    kitty
    networkmanagerapplet

# Fun Terminal Commands

    #cmatrix
    #hollywood
    #nms
    #pipes

# Music

    mpd
    mpc-cli

# Streaming

    vscodium

# Design

    figma-linux
    inkscape

# Torrent

    qbittorrent

# Office

    libreoffice-fresh
    evince

# Password Manager

    keepassxc

# Communication

    tor-browser-bundle-bin

# Video Editing

    blender

# Miscellaneous

    bottles
    imagemagick
    #feh
    qimgv
    rofi-wayland
    cliphist
    grim
    pavucontrol
    font-manager
    easyeffects
    librewolf

# Themes

    #bibata-cursors
    #whitesur-icon-theme

    #
    nushell
    gnome.nautilus
    firefox
    ocrmypdf
    rig
    tree
    hyprpicker
    cava
    broot
    wl-clipboard
    calibre
    wineWowPackages.staging
    eww-wayland
    wireguard-tools
    alacritty
    glow
    nwg-dock-hyprland
    nix-prefetch-git
  ];
}
