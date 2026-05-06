
{ lib, custom, pkgs, ... }:
lib.mkIf custom.gui.enable {
  # Install wallpaper program
  home.packages = with pkgs; [
    awww
  ];
  # Enable wallpaper daemon
  # services.awww.enable = true; # TODO: Use this instead of hyprland start script (does not work out of the box)
}
