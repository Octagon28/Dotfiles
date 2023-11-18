{ pkgs, ... }:

{
    programs.nixvim = {
        enable = true;
        viAlias = true;
        vimAlias = true;
        extraPlugins = with pkgs.vimPlugins; [ vim-nix vim-markdown ];
        extraConfigVim = builtins.readFile ./vimrc;
    };
}