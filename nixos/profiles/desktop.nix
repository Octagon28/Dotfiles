{ config, pkgs, lib, ... }:

{

# Hardware

    hardware.sane.enable = true;
    hardware.bluetooth.enable = true;
    hardware.opengl.driSupport = true;
    hardware.opengl.driSupport32Bit = true;
  
# Internationalization

    i18n.defaultLocale = "en_US.UTF-8";
    time.timeZone = "Europe/Minsk";

# Bootloader

    boot.initrd.systemd.enable = true;
    boot.loader.efi.efiSysMountPoint = "/boot/efi";
    boot.initrd.kernelModules = [ "amdgpu" ];
  
# Services
   
    services.gvfs.enable = true;
    services.microbin.enable = true;
    services.printing.enable = true;
    services.xserver = {
        enable = true;
        videoDrivers = [ "amdgpu" ];
        displayManager = {
        sddm = {
            enable = true;
            wayland.enable = true;
            theme = "where_is_my_sddm_theme";
            settings = {
                Item = {
                    id = "cursor";
                    visible = "false";
                };
            };
          };
        };
    };

    environment.systemPackages = [
    (pkgs.where-is-my-sddm-theme.override {
      themeConfig.General = {
        passwordFontSize = 25;
        sessionsFontSize = 25;
        usersFontSize = 25;
        cursorColor = "#ffffff";
      };
    })
  ];

    systemd.services.display-manager.serviceConfig.LogNamespace = "graphical-session";
    environment.etc."systemd/journald@graphical-session.conf".text = ''
      [Journal]
      SystemMaxUse=200M
    '';
    
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
    programs.firejail.wrappedBinaries = {
    #firefox = {
    #    executable = "﹩{pkgs.lib.getBin pkgs.firefox}/bin/firefox";
    #    profile = "﹩{pkgs.firejail}/etc/firejail/firefox.profile"; 
    #};
    #chromium = {
    #    executable = "﹩{pkgs.lib.getBin pkgs.chromium}/bin/chromium";
    #    profile = "﹩{pkgs.firejail}/etc/firejail/chromium.profile";
    #};
};

# Antivirus

    services.clamav.daemon.enable = true;
    services.clamav.updater.enable = true;

# User

    users.defaultUserShell = pkgs.zsh;
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

    environment = {
      shells = [ pkgs.zsh ];
      variables = {
          EDITOR = "nvim";
          SYSTEMD_EDITOR = "nvim";
          VISUAL = "nvim";
      };
    };

  fonts.packages = with pkgs; [
    dejavu_fonts
    jetbrains-mono
    nerdfonts
    rubik
    inter
  ];

  security.polkit.enable = true;
  services.networkd-dispatcher = {
  enable = true;
  rules."restart-tor" = {
    onState = ["routable" "off"];
    script = ''
      #!${pkgs.runtimeShell}
      if [[ $IFACE == "wlan0" && $AdministrativeState == "configured" ]]; then
        echo "Restarting Tor ..."
        systemctl restart tor
      fi
      exit 0
    '';
  };
};

programs.zsh = {
  enable = true;
  shellAliases = {
    ll = "ls -l";
    update = "sudo nixos-rebuild switch";
  };
  autosuggestions.enable = true;
  syntaxHighlighting.enable = true;
  histSize = 10000;
  histFile = "$HOME/.zsh_history";

   ohMyZsh = {
    enable = true;
    plugins = [ "git" "thefuck" ];
    theme = "robbyrussell";
  };
};

programs.starship = { enable = true;
         settings = {
         add_newline = false;
         character = { 
         success_symbol = "[➜](bold green)";
         error_symbol = "[➜](bold red)";
       };
    };
};

}