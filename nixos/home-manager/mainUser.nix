{ custom, pkgs, ... }:
let
  mainUser = custom.mainUser;
in
{
  imports = [
    ./modules.nix
  ];
  home = {
    username = mainUser.username;
    homeDirectory = mainUser.homeDir;
    # User packages
    packages = with pkgs; [
      hello
    ];
    # Read comment in default config before changing
    stateVersion = "25.11";
  };
  programs.home-manager.enable = true;
}
