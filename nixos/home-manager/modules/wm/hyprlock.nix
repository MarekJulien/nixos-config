{ lib, custom, pkgs, ... }:
lib.mkIf custom.gui.enable {
  home.packages = [ pkgs.hyprlock ];
  # TODO: Transfer config to home-manager
  # programs.hyprlock = {
  #   enable = true;
  #   settings = {
  #
  #   };
  # };
}
