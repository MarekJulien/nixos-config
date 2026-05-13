{ custom, config, lib, pkgs, ... }:

 lib.mkIf custom.gui.enable {
  ##### Stylix #####
  stylix = {
    # Documentation: https://nix-community.github.io/stylix/options/platforms/home_manager.html
    enable = true;
    enableReleaseChecks = false;
    autoEnable = true;
    # Disable specific targets
    targets = {
      nvf.enable = false; # Found no working solution with trasparent bg so far
    };
    # Color scheme (https://tinted-theming.github.io/tinted-gallery/)
    base16Scheme = "${pkgs.base16-schemes}/share/themes/catppuccin-mocha.yaml";
    polarity = "dark";

    # Cursor
    # cursor
    # cursor.name
    # cursor.package
    # cursor.size

    # Fonts
    # fonts.sizes.applications
    # fonts.sizes.desktop
    # fonts.sizes.popups
    # fonts.sizes.terminal
    # fonts.packages
    # fonts.emoji.name
    # fonts.emoji.package
    # fonts.monospace.name
    # fonts.monospace.package
    # fonts.sansSerif.name
    # fonts.sansSerif.package
    # fonts.serif.name
    # fonts.serif.package

    # Icons
    # icons.enable
    # icons.package
    # icons.dark
    # icons.light

    # Wallpaper image
    # image
    # imageScalingMode

    # Opacity
    # opacity.applications
    # opacity.desktop
    # opacity.popups
    # opacity.terminal
    # overlays.enable
    # override
  };

  ##### Custom #####
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
  dconf = {
    enable = true;
    settings = {
      "org/gnome/desktop/interface" = {
        color-scheme = lib.mkForce "prefer-dark";
      };
    };
  };

}
