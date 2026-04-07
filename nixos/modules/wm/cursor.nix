{ config, lib, pkgs, ... }:

let
  cursorSize = config.custom.cursor.size;
in
{
  options.custom.cursor.size = lib.mkOption {
    type = lib.types.int;
    default = 20;
  };

  config = {
    environment.systemPackages = [ pkgs.bibata-cursors ];
    environment.variables = {
      XCURSOR_THEME = "Bibata-Modern-Classic";
      XCURSOR_SIZE = toString cursorSize;
    };
    environment.etc."gtk-3.0/settings.ini".text = ''
      [Settings]
      gtk-cursor-theme-name=Bibata-Modern-Classic
      gtk-cursor-theme-size=${toString cursorSize}
    '';
    environment.etc."gtk-4.0/settings.ini".text = ''
      [Settings]
      gtk-cursor-theme-name=Bibata-Modern-Classic
      gtk-cursor-theme-size=${toString cursorSize}
    '';
  };
}