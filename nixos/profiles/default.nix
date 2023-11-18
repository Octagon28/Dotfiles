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
        inputs.nixvim.homeManagerModules.nixvim
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
         kernelParams = [ "quiet" "splash" "rd.systemd.show_status=false" "rd.udev.log_level=3" "udev.log_priority=3" "boot.shell_on_fail" ];
         
	 plymouth = {
	 enable = true;
         themePackages = [ pkgs.adi1090x-plymouth-themes ];
         theme = "cuts_alt";
	 };
	 
	loader = {
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

