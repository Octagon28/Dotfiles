{ inputs, config, pkgs, user, ... }:

{
  imports = [
      ./apps.nix
      ../settings/kitty
      ../settings/neovim
      ../settings/easyeffects
      ../settings/git
      ../settings/hyprland
      ../settings/yazi
      ../settings/nix-colors
      ../settings/ags
      ../settings/alacritty
    ]; 

# Settings

	home.file.".wallpapers".source = ../settings/wallpapers;
  home.file.".config/eww".source = ../settings/eww;
	
  home.sessionVariables = {
    EDITOR = "nvim";
    VISUAL = "nvim";
  };



# Nixpkgs Settings

	nixpkgs = {
		config = {
			allowUnfree = true;
			allowUnfreePredicate = (_: true);
			}; };

qt = {
  enable = true;
  platformTheme = "gtk";
};

home.pointerCursor = {
    name = "Bibata-Modern-Classic";
    package = pkgs.bibata-cursors;
    size = 35;
    gtk.enable = true;
    x11.enable = true;
};

gtk = {
  enable = true;
  font = {
    name = "Inter Regular";
    package = pkgs.inter;
    size = 10;
  };
  iconTheme = {
    name = "WhiteSur-dark";
    package = pkgs.whitesur-icon-theme;
  };
  theme = {
    name = "Graphite-Dark";
    package = pkgs.graphite-gtk-theme;
  };

  gtk3 = {
    extraConfig = {
      gtk-decoration-layout = "appmenu:none";
      gtk-toolbar-style="GTK_TOOLBAR_ICONS";
      gtk-toolbar-icon-size="GTK_ICON_SIZE_LARGE_TOOLBAR";
      gtk-button-images=0;
      gtk-menu-images=0;
      gtk-enable-event-sounds=1;
      gtk-enable-input-feedback-sounds=0;
      gtk-xft-antialias=1;
      gtk-xft-hinting=1;
      gtk-xft-hintstyle="hintfull";
      gtk-xft-rgba="rgb";
      gtk-application-prefer-dark-theme=1;
    };
  };

 gtk4.extraConfig.gtk-decoration-layout = "appmenu:none";
};


# Nushell

	programs = {
    nushell = { enable = true;
       extraConfig = ''
	   alias fuck = with-env {TF_ALIAS: "fuck", PYTHONIOENCODING: "utf-8"} {
       thefuck (history | last 1 | get command.0)
	    } 
       let carapace_completer = {|spans|
       carapace $spans.0 nushell $spans | from json
       }
        $env.config = {
        show_banner: false,
        completions: {
        case_sensitive: false 
        quick: true    
        partial: true    
        algorithm: "fuzzy"    
        external: {
            enable: true 
            max_results: 100 
            completer: $carapace_completer 
          }
        }
       } 
       $env.PATH = ($env.PATH | 
       split row (char esep) |
       prepend /home/clover/.apps |
       append /usr/bin/env
       )
       '';
   };  
   carapace.enable = true;
   carapace.enableNushellIntegration = true;
   };


	
}