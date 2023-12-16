{ lib, inputs, nixpkgs, home-manager, user, configDir, ... }:

let
    system = "x86_64-linux";
    pkgs = import nixpkgs {
        inherit system;
        config.allowUnfree = true; };

    lib = nixpkgs.lib;
    configImports = [
        ./configuration.nix ];

    hmImports = [
      (import ./home.nix)
        inputs.ags.homeManagerModules.default
        inputs.nix-colors.homeManagerModules.default
        inputs.nixvim.homeManagerModules.nixvim
        inputs.hyprland.homeManagerModules.default
        {wayland.windowManager.hyprland.enable = true;}
        ];

    desktopHmImports = hmImports ++ [
        (import ./home-desktop.nix) ];

    hmArgs = { inherit user configDir; };
in

{
  clover = lib.nixosSystem {
    inherit system;
    specialArgs = { inherit user; inherit inputs; };
    modules = configImports ++ [
      ./clover
      ./desktop.nix
      {
	  boot = {
         consoleLogLevel = 0;
         initrd.verbose = false;
         kernelParams = [ "quiet" "udev.log_level=0" ];
         # "splash" "rd.systemd.show_status=false" "boot.shell_on_fail"
	       plymouth = {
            enable = true;
            themePackages = [ pkgs.adi1090x-plymouth-themes ];
            theme = "seal_2";
            extraConfig = ''
                [Unit]
                Conflicts=plymouth-quit.service
                After=plymouth-quit.service rc-local.service plymouth-start.service systemd-user-sessions.service
                OnFailure=plymouth-quit.service

                [Service]
                ExecStartPre=-/usr/bin/plymouth deactivate
                ExecStartPost=-/usr/bin/sleep 30
                ExecStartPost=-/usr/bin/plymouth quit --retain-splash
            '';
	 };
	 
	loader = {
        systemd-boot.enable = true;
        efi.canTouchEfiVariables = true;
        timeout = 0;
    };
  };
        networking.hostName = "${user}";
      }
      home-manager.nixosModules.home-manager {
        home-manager = {
          useUserPackages = true;
          extraSpecialArgs = { inherit user; };
          users.${user} = {
            imports = desktopHmImports ++ [
              (import ./clover/home.nix)
            ];
          };
        };
      }
    ];
  };

}

