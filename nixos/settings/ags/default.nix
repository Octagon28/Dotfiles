{ pkgs, ... }:

{
    programs.ags = {
        enable = true;
        configDir = ../ags;
        extraPackages = [ pkgs.libsoup_3 ];
    };
}