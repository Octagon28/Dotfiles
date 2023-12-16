{ user, ... }:

{
    home = {
        username = "${user}";
        homeDirectory = "/home/${user}";
        sessionVariables = {
            CARGO_TARGET_DIR = "$HOME/.target/"; };

      stateVersion = "23.11";
  };

  programs.direnv.enable = true;
}
