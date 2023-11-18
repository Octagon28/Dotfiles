{ inputs, config, pkgs, user, ... }:

{
    imports = [ 
      /apps.nix
      ../settings/kitty
      ../settings/neovim
      ../settings/easyeffects
    ]; 

# Settings

	home.file.".config/hypr".source = ../settings/hypr;
	home.file.".wallpapers".source = ../settings/wallpapers;
	
# Nixpkgs Settings

	nixpkgs = {
		config = {
			allowUnfree = true;
			allowUnfreePredicate = (_: true);
			permittedInsecurePackages = [ "figma-linux-0.10.0" ]; }; };



qt = {
  enable = true;
  platformTheme = "gtk";
};

gtk = {
  enable = true;
  iconTheme = {
    name = "WhiteSur-dark";
    package = pkgs.whitesur-icon-theme;
  };
  theme = {
    name = "Graphite-Dark";
    package = pkgs.graphite-gtk-theme;
  };

  gtk3 = {
    extraCOnfig = {
      gtk-decoration-layout = "appmenu:none";
      gtk-cursor-theme-name=Bibata-Modern-Classic;
      gtk-cursor-theme-size=40;
      gtk-font-name=Noto Sans,  10
      gtk-toolbar-style=GTK_TOOLBAR_ICONS;
      gtk-toolbar-icon-size=GTK_ICON_SIZE_LARGE_TOOLBAR;
      gtk-button-images=0;
      gtk-menu-images=0;
      gtk-enable-event-sounds=1;
      gtk-enable-input-feedback-sounds=0;
      gtk-xft-antialias=1;
      gtk-xft-hinting=1;
      gtk-xft-hintstyle=hintfull;
      gtk-xft-rgba=rgb;
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

   starship = { enable = true;
         settings = {
         add_newline = false;
         character = { 
         success_symbol = "[➜](bold green)";
         error_symbol = "[➜](bold red)";
       };
    };
   };
};
	
}