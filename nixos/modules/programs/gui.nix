{ lib, config, pkgs, ... }:

lib.mkIf config.custom.gui.enable {
    environment.systemPackages = with pkgs; [
      alacritty
      brave
      keepassxc
      gimp
      libreoffice
      pcmanfm
      vlc
    ];
}
