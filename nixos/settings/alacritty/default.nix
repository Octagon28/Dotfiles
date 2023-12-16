{ pkgs, ... }:

{
    programs.alacritty = {
        enable = true;
        settings = {
            window = {
            padding = {
                x = 5;
                y = 5;
            };

            opacity = 1;
            };

            scrolling = {
            history = 10000;
            multiplier = 3;
            };

            font = {
            normal = {
                family = "SauceCodePro";
                style =  "Regular";
            };
            bold = {
                family = "SauceCodePro";
                style = "Bold";
            };
            italic = {
                family = "SauceCodePro";
                style =  "Italic";
            };
            bold_italic = {
                family = "SauceCodePro";
                style = "Bold Italic";
            };
            size = 11.1;
            #raw_bold_text_with_bright_colors = true;
            };
        };
    };
}