{ pkgs, ... }:

{
    programs.yazi = {
        enable = true;
        settings = {
            manager = {
            layout         = [ 1 4 3 ];
            sort_by        = "alphabetical";
            sort_sensitive = true;
            sort_reverse   = true;
            sort_dir_first = true;
            linemode       = "size";
            show_hidden    = true;
            show_symlink   = true;
            };

            preview = {
            tab_size        = 2;
            max_width       = 600;
            max_height      = 900;
            cache_dir       = "";
            ueberzug_scale  = 1;
            ueberzug_offset = [ 0 0 0 0 ];
            };

            tasks = {
            micro_workers = 5;
            macro_workers = 10;
            bizarre_retry = 5;
            };

            log = {
            enabled = false;
            };

            opener = {
                edit = [
                    { exec = "nvim \"$@\""; block = true;  for = "unix"; }
                    { exec = "code \"%*\"";    orphan = true; for = "windows"; }
                ];
                };
        };
        theme = {
            manager = {
            border_symbol = " ";
            };
        };
    };
}