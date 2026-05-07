{ lib, custom, config, pkgs, ... }:
lib.mkIf custom.gui.enable {
  # qt = {
  #   enable = true;
  #   platformTheme.name = "gtk";
  # };
  gtk = {
    enable = true;
    gtk4.theme = config.gtk.theme;
    # theme = {
    #   package = pkgs.nordic;
    #   name = "Nordic-darker";
    # };
    iconTheme = {
      # package = pkgs.paper-icon-theme;
      # name = "Paper";
      package = pkgs.papirus-icon-theme;
      name = "Papirus";
    };
  };
  # dconf.settings = {
  #   "org/gnome/desktop/interface" = {
  #     color-scheme = "prefer-dark";
  #   };
  # };
}
