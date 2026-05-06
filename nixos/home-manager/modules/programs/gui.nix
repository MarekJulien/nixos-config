{ lib, custom, pkgs, ... }:

lib.mkIf custom.gui.enable {
  home.packages = with pkgs; [
    alacritty
    brave
    keepassxc
    gimp
    libreoffice
    pcmanfm
    vlc
  ];
}
