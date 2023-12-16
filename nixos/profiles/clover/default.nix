{ config, ... }:

{
  imports = [ (import ./hardware-configuration.nix) ];

  services.blueman.enable = true;

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";

  # Support mounting NTFS partition
  boot.supportedFilesystems = [ "ntfs" ];
}
