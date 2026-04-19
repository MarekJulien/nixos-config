{ lib, config, ... }:

lib.mkIf config.custom.gui.enable {
  # GTK Theme
  programs.dconf.enable = true;
  environment.variables = {
    GTK_THEME = "Adwaita-dark";
  };
  # QT Theme
  qt = {
    enable = true;
    platformTheme = "gnome";
    style = "adwaita-dark";
  };
}