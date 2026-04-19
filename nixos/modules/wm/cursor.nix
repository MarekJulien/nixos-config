{ lib, config, pkgs, ... }:

let
  cursorSize = config.custom.gui.cursor.size;
  cursorTheme = config.custom.gui.cursor.theme;

  cursorPackages = {
    "Bibata-Modern-Classic" = pkgs.bibata-cursors;
    "Bibata-Modern-Ice" = pkgs.bibata-cursors;
    "Adwaita" = pkgs.gnome.adwaita-icon-theme;
  };
  cursorPkg =
    cursorPackages.${cursorTheme}
    or (throw "Unknown cursor theme: ${cursorTheme}");
in
{
  config = lib.mkIf config.custom.gui.enable {
    environment.systemPackages = [ cursorPkg ];
    environment.variables = {
      XCURSOR_THEME = toString cursorTheme;
      XCURSOR_SIZE = toString cursorSize;
    };
    environment.etc."gtk-3.0/settings.ini".text = ''
      [Settings]
      gtk-cursor-theme-name=${toString cursorTheme}
      gtk-cursor-theme-size=${toString cursorSize}
    '';
    environment.etc."gtk-4.0/settings.ini".text = ''
      [Settings]
      gtk-cursor-theme-name=${toString cursorTheme}
      gtk-cursor-theme-size=${toString cursorSize}
    '';
  };
}