{
  description = "My NixOS configuration";

  inputs = {
    musnix.url = "github:musnix/musnix";
    hyprland.url = "github:hyprwm/Hyprland";
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = inputs@{ self, nixpkgs, home-manager, ... }:
    let
      user = "clover";
      configDir = "nix-config";
    in {
      nixosConfigurations = import ./Profiles {
        inherit (nixpkgs) lib;
        inherit inputs nixpkgs home-manager user configDir;
      };
    };
}