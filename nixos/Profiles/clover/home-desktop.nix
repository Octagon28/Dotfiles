{ inputs, config, pkgs, user, ... }:

{
    imports = [ ./apps.nix ]; 

# Dotfiles

	home.file.".config/hypr".source = ../dotfiles/hypr;
	home.file.".config/btop".source = ../dotfiles/btop;
	home.file.".config/kitty".source = ../dotfiles/kitty;
	home.file.".wallpapers".source = ../dotfiles/.wallpapers;
	home.file.".config/gtk-2.0".source = ../dotfiles/gtk-2.0;
	home.file.".config/gtk-3.0".source = ../dotfiles/gtk-3.0;
	home.file.".config/gtk-4.0".source = ../dotfiles/gtk-4.0;
	home.file.".config/easyeffects".source = ../dotfiles/easyeffects;
	
# Nixpkgs Settings

	nixpkgs = {
		config = {
			allowUnfree = true;
			allowUnfreePredicate = (_: true);
			permittedInsecurePackages = [ "figma-linux-0.10.0" ]; }; };

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

	programs.neovim = {
		enable = true;
		defaultEditor = true;
		viAlias = true;
		vimAlias = true;
		extraConfig = ''
			set clipboard=unnamedplus
			set number relativenumber
			set shiftwidth=4
			set tabstop=4
			set expandtab
			filetype plugin indent on
			set autoindent
			set ttyfast
			'';
	};

	programs.home-manager.enable = true;
	
}