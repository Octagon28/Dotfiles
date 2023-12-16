{ pkgs, ... }:

{
    programs.kitty = {
        enable = true;
        font = {
            name = "SauceCode";
            size = 11.1;
        };
        settings = {
            window_margin_width = 7;
            remember_window_size = false;
            confirm_os_window_close = 0;
            dynamic_background_opacity = true;
            enable_audio_bell = false;
            background_opacity = "0.75";
            mouse_hide_wait = "-1.0";
            repaint_delay = 60;
            shell_integration = "no-cursor";
        };
        extraConfig = "
        # The basic colors
        foreground                      #969696
        background                      #0c0c0e
        selection_foreground            #bbc2cf
        selection_background            #3f444a

        # Cursor colors
        cursor                          #bbc2cf
        cursor_text_color               #282c34

        # kitty window border colors
        active_border_color     #46D9FF
        inactive_border_color   #3f444a

        # Tab bar colors
        active_tab_foreground   #282c34
        active_tab_background   #DFDFDF
        inactive_tab_foreground #3f444a
        inactive_tab_background #5B6268

        # The basic 16 colors
        # black
        color0 #2a2e38
        color8 #3f444a

        # red
        color1 #cb2025
        color9 #e53238

        # green
        color2  #9cbb35
        color10 #a4c639

        # yellow
        color3  #ffc414
        color11 #ffcb31

        # blue
        color4  #0f9fff
        color12 #008ae6

        # magenta
        color5  #9C27B0
        color13 #BA68C8

        # cyan
        color6  #46D9FF
        color14 #46D9FF

        # white
        color7  #DFDFDF
        color15 #bbc2cf


        # Important Environment Variables
        EDITOR      nvim
        DISPLAY     nvim
        ";
    };
}