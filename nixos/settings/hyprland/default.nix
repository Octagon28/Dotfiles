{ pkgs, ... }:

{
    wayland.windowManager.hyprland = {
        enable = true;
        xwayland.enable = true;
        extraConfig = ''

        # Monitors
        monitor=HDMI-A-1,1920x1080@60,0x0,1
        monitor=eDP-1,1920x1080@60,1920x0,1

        # Executed on start
        exec-once = swww init
        exec-once = swww img /etc/nixos/settings/wallpapers/wallhaven-nrd3wqv2.jpg
        exec-once = systemctl --user import-environment WAYLAND_DISPLAY XDG_CURRENT_DESKTOP 
        exec-once = blueman-applet 
        exec-once = nm-applet --indicator 
        exec-once = wl-paste --type text --watch cliphist store #Stores only text data
        exec-once = wl-paste --type image --watch cliphist store #Stores only image data
        exec-once = hyprctl setcursor Bibata-Modern-Classic 35

        gsettings set org.gnome.desktop.interface cursor-theme Bibata-Modern-Classic


        env = XCURSOR_SIZE,35
        env = WLR_NO_HARDWARE_CURSORs,1

        # Variables
        input {
            kb_layout = us
            accel_profile = adaptive
            follow_mouse = 1
            sensitivity = 0.5
        }

        general {
            gaps_in = 3
                gaps_out = 13
                border_size = 7
                col.active_border = rgb(242426)
                col.inactive_border = rgb(242426)

                layout = dwindle
        }

        decoration {
        
            rounding = 2

                blur {
                    enabled = true
                        size = 15
                        passes = 0
                        new_optimizations = true
                        #ignore_opacity = true
                        #brightness = 0.60
                }

                drop_shadow = true
                shadow_range = 3
                shadow_render_power = 3
                col.shadow = rgba(#333333)
        }

        dwindle {
            pseudotile = true 
                preserve_split = true 
        }

        master {
            new_is_master = true
        }

        gestures {
            workspace_swipe = false
        }

        misc {
            force_default_wallpaper = -1 # Set to 0 to disable the anime mascot wallpapers
        }

        device:epic-mouse-v1 {
                sensitivity = -0.5
            }

        misc {
            disable_hyprland_logo = true
        }

        # Binds
        $mainMod = SUPER

        bind = $mainMod, Q, exec, kitty
        bind = $mainMod, W, killactive,
            bind = $mainMod, M, exit,
            # bind = $mainMod, F, fullscreen
            bind = $mainMod, E, exec, kitty yazi
            bind = $mainMod, A, exec, rofi -show drun
            bind = $mainMod, V, togglefloating,
            bind = $mainMod, R, exec, wofi --show drun
            bind = $mainMod, P, pseudo, # dwindle
            bind = $mainMod, J, togglesplit, # dwindle
            bind = $mainMod, Print, exec, grim -g "$(slurp)"

        # Move focus with mainMod + arrow keys
            bind = $mainMod, left, movefocus, l
            bind = $mainMod, right, movefocus, r
            bind = $mainMod, up, movefocus, u
            bind = $mainMod, down, movefocus, d

        # Switch workspaces with mainMod + [0-9]
            bind = $mainMod, 1, workspace, 1
            bind = $mainMod, 2, workspace, 2
            bind = $mainMod, 3, workspace, 3
            bind = $mainMod, 4, workspace, 4
            bind = $mainMod, 5, workspace, 5
            bind = $mainMod, 6, workspace, 6
            bind = $mainMod, 7, workspace, 7
            bind = $mainMod, 8, workspace, 8
            bind = $mainMod, 9, workspace, 9
            bind = $mainMod, 0, workspace, 10

        # Move active window to a workspace with mainMod + SHIFT + [0-9]
            bind = $mainMod SHIFT, 1, movetoworkspace, 1
            bind = $mainMod SHIFT, 2, movetoworkspace, 2
            bind = $mainMod SHIFT, 3, movetoworkspace, 3
            bind = $mainMod SHIFT, 4, movetoworkspace, 4
            bind = $mainMod SHIFT, 5, movetoworkspace, 5
            bind = $mainMod SHIFT, 6, movetoworkspace, 6
            bind = $mainMod SHIFT, 7, movetoworkspace, 7
            bind = $mainMod SHIFT, 8, movetoworkspace, 8
            bind = $mainMod SHIFT, 9, movetoworkspace, 9
            bind = $mainMod SHIFT, 0, movetoworkspace, 10

        # Scroll through existing workspaces with mainMod + scroll
            bind = $mainMod, mouse_down, workspace, e+1
            bind = $mainMod, mouse_up, workspace, e-1

        # Move/resize windows with mainMod + LMB/RMB and dragging
            bindm = $mainMod, mouse:272, movewindow
            bindm = $mainMod, mouse:273, resizewindow

        animations {
            enabled = yes
            bezier = wind, 0.05, 0.9, 0.1, 1.05
            bezier = winIn, 0.1, 1.1, 0.1, 1.1
            bezier = winOut, 1, -0.3, 0, 1
            bezier = liner, 1, 1, 1, 1
            animation = windows, 1, 6, wind, slide
            animation = windowsIn, 1, 6, winIn, slide
            animation = windowsOut, 1, 5, winOut, slide
            animation = windowsMove, 1, 5, wind, slide
            animation = border, 1, 1, liner
            animation = borderangle, 1, 50, liner, loop
            animation = fade, 0, 1, default
            animation = workspaces, 1, 5, wind
        }
        '';
    };

}