{ pkgs, ... }:

{
  home.packages = with pkgs; [

# Development

    cmake
    dbus
    git
    gnat13
    jdk
    python312

# Terminal Applications

    btop
    clamav
    coreutils-full
    eww-wayland
    ffmpeg_6-full
    findutils
    grc
    helix
    killall
    light
    lightdm
    lynx
    mesa
    mpd
    mpc-cli
    mpv
    multipath-tools
    neofetch
    ncmpcpp
    newsboat
    perl538Packages.WWWYoutubeViewer
    plymouth
    ripgrep
    rm-improved
    slurp
    swww
    termshark
    thefuck
    translate-shell
    tre
    unar
    veracrypt
    warp
    wikicurses
    wttrbar

# GUI Applications
    
    alsa-scarlett-gui
    kitty
    networkmanagerapplet

# Fun Terminal Commands

    cmatrix
    hollywood
    nms
    pipes

# Music

    mpd
    mpc-cli

# Streaming

    vscodium

# Design

    #figma-linux
    inkscape

# Torrent

    qbittorrent

# Office

    libreoffice-fresh
    evince

# Password Manager

    keepassxc

# Communication

    nicotine-plus
    tor-browser-bundle-bin

# Video Editing

    libsForQt5.kdenlive
    blender

# Miscellaneous

    bottles
    docker
    imagemagick
    feh
    qimgv
    rofi-wayland
    nwg-look
    cliphist
    grim
    pavucontrol
    font-manager
    gradience
    easyeffects
    ungoogled-chromium

# Themes

    bibata-cursors
    graphite-gtk-theme
    whitesur-icon-theme

# Fonts
    
    dejavu_fonts
    jetbrains-mono
    nerdfonts
    rubik

    #
    yazi
    nushell
    imgbrd-grabber
    gnome.nautilus
    figma-linux
    firefox
    ocrmypdf
    rig
    hyprpicker
    cava
    gimp-with-plugins
    wl-clipboard
  ];
}
