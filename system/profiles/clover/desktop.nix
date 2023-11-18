{ config, pkgs, lib, ... }:

{

# Hardware

    hardware.sane.enable = true;
    services.blueman.enable = true;
    hardware.bluetooth.enable = true;
    hardware.opengl.driSupport = true;
    hardware.opengl.driSupport32Bit = true;
  
# Internationalization

    i18n.defaultLocale = "en_US.UTF-8";
    time.timeZone = "Europe/Minsk";

# Bootloader

    boot.loader.systemd-boot.enable = true;
    boot.initrd.systemd.enable = true;
    boot.loader.efi.canTouchEfiVariables = true;
    boot.loader.efi.efiSysMountPoint = "/boot/efi";
    boot.initrd.kernelModules = [ "amdgpu" ];
    boot.supportedFilesystems = [ "ntfs" ];
  
# Services
   
    services.gvfs.enable = true;
    services.microbin.enable = true;
    services.printing.enable = true;
    services.xserver.enable = true;
    services.xserver.videoDrivers = [ "amdgpu" ];
    services.xserver.desktopManager.gnome.extraGSettingsOverrides = "gsettings set org.gnome.desktop.wm.preferences button-layout :";
    services.xserver.displayManager.gdm.enable = true;
    #services.xserver.displayManager.lightdm.extraConfig = "";
    services.mpd = {
        enable = true;
        musicDirectory = "/home/clover/Music";
        extraConfig = ''
        audio_output {
        type "pipewire"
        name "My PipeWire Output"
    }
    '';
    };
    services.mpd.user = "clover";
    systemd.services.mpd.environment = {
    XDG_RUNTIME_DIR = "/run/user/1000"; 
};

    services.pipewire = {
        enable = true;
        alsa.enable = true;
        alsa.support32Bit = true;
        pulse.enable = true;
        jack.enable = true;
    };
      services.fail2ban = {
    enable = true;
    maxretry = 5; # Observe 5 violations before banning an IP
    ignoreIP = [
      # Whitelisting some subnets:
      "10.0.0.0/8" "172.16.0.0/12" "192.168.0.0/16"
      "8.8.8.8" # Whitelists a specific IP
      "nixos.wiki" # Resolves the IP via DNS
    ];
    bantime = "24h"; # Set bantime to one day
    bantime-increment = {
      enable = true; # Enable increment of bantime after each violation
      formula = "ban.Time * math.exp(float(ban.Count+1)*banFactor)/math.exp(1*banFactor)";
      #multipliers = "1 2 4 8 16 32 64";
      maxtime = "168h"; # Do not ban for more than 1 week
      overalljails = true; # Calculate the bantime based on all the violations
    };
    jails = {
      apache-nohome-iptables = ''
        # Block an IP address if it accesses a non-existent
        # home directory more than 5 times in 10 minutes,
        # since that indicates that it's scanning.
        filter = apache-nohome
        action = iptables-multiport[name=HTTP, port="http,https"]
        logpath = /var/log/httpd/error_log*
        backend = auto
        findtime = 600
        bantime  = 600
        maxretry = 5
      '';
    };
  };

  programs.steam = {
  enable = true;
  remotePlay.openFirewall = true; # Open ports in the firewall for Steam Remote Play
  dedicatedServer.openFirewall = true; # Open ports in the firewall for Source Dedicated Server
};
  
# Networking

    networking.firewall.enable = true;
    networking.firewall.allowedTCPPorts = [ ];
    networking.firewall.allowedUDPPorts = [ ];
    networking = { networkmanager.enable = true; };

# Security

    security.rtkit.enable = true;
    systemd.coredump.enable = false;
    security.chromiumSuidSandbox.enable = true;
    programs.firejail.enable = true;

# Antivirus

    services.clamav.daemon.enable = true;
    services.clamav.updater.enable = true;

# User

    users.defaultUserShell = pkgs.nushell;
    environment.etc = {
      "pipewire/pipewire.conf.d/92-low-latency.conf".text = ''
        context.properties = {
        default.clock.rate = 192000
        #default.clock.quantum = 32
        #default.clock.min-quantum = 32
	    #default.clock.max-quantum = 32
     }
  '';
};

    security.sudo.configFile = ''
    clover ALL=(ALL) NOPASSWD:/usr/bin/env nvim
'';

    environment.variables = { 
        EDITOR = "nvim"; 
        VISUAL = "nvim";
        };
}