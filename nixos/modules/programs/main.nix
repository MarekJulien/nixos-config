{ lib, config, pkgs, ... }:

lib.mkIf config.custom.gui.enable {
    environment.systemPackages = with pkgs; [
      brave
      keepassxc
      gimp
      libreoffice
      vesktop
    ];
}
