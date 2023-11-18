{ config, ... }:

{
  imports = [ (import ./hardware-configuration.nix) ];

  services.blueman.enable = true;

  hardware.opengl = {
    enable = true;
    driSupport32Bit = true; # Required for Touhou
  };
  
  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";

  # Enable the GNOME Desktop Environment.
  # services.xserver.displayManager.gdm.enable = true;
  # services.xserver.desktopManager.gnome.enable = true;

  # Support mounting NTFS partition
  boot.supportedFilesystems = [ "ntfs" ];
}
