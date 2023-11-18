{ pkgs, ... }:

{
    programs.kitty = {
        enable = true;
        font = {
            name = "JetBrainsMono";
            size = 11.1;
        };
        settings = {
            window_margin_width = 7;
            remember_window_size = false;
            confirm_os_window_close = 0;
        };
        extraConfig = "
        background            #0c0c0e
        foreground            #ffffff
        cursor                #355ba1
        selection_background  #073642
        color0                #ffffff
        color8                #355BA1
        color1                #dc322f
        color9                #dc322f
        color2                #355BA1
        color10               #56db3a
        color3                #ff8400
        color11               #ff8400
        color4                #355BA1
        color12               #355BA1
        color5                #dc322f
        color13               #355BA1
        color6                #60232c
        color14               #ffffff
        color7                #ffffff
        color15               #ffffff
        selection_foreground  #000000";
    };
}