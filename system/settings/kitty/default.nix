{ pkgs, ... };

{
    programs.kitty = {
        enable = true;
        font = {
            name = "JetBrainsMono";
            size = 11.1;
        };
        extraConfig = "window_margin_width 7\remember_window_size no\confirm_os_window_close 0\include current-theme.conf"
    };
}