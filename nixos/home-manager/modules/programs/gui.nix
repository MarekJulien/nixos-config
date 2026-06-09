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
    qimgv # Image viewer
  ];
  # Default applications # TODO: Make dynamic
  xdg.mimeApps = {
    enable = true;
    defaultApplications = {
      "image/jpeg" = [ "qimgv.desktop" ];
      "image/png"  = [ "qimgv.desktop" ];
      "image/webp" = [ "qimgv.desktop" ];
      "image/gif"  = [ "qimgv.desktop" ];
      "image/bmp"  = [ "qimgv.desktop" ];
    };
  };
}
