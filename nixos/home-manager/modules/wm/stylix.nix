{ custom, config, lib, pkgs, ... }:
let
  ### Cursor ###
  cursorSize = custom.gui.cursor.size;
  cursorThemeName = custom.gui.cursor.theme;
  cursorPackages = {
    "Bibata-Modern-Classic" = pkgs.bibata-cursors;
    "Bibata-Modern-Ice" = pkgs.bibata-cursors;
    "Adwaita" = pkgs.gnome.adwaita-icon-theme;
  };
  cursorPkg =
    cursorPackages.${cursorThemeName}
    or (throw "Unknown cursor theme: ${cursorThemeName}");
  ### Icon Theme ###
  iconThemeName = custom.gui.iconTheme;
  iconThemePackages = {
    "Papirus" = pkgs.papirus-icon-theme;
    "Paper" = pkgs.paper-icon-theme;
    "WhiteSur" = pkgs.whitesur-icon-theme;
  };
  iconThemePkg =
    iconThemePackages.${iconThemeName}
    or (throw "Unknown cursor theme: ${cursorThemeName}");
in
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
    cursor = {
      name = cursorThemeName;
      package = cursorPkg;
      size = cursorSize;
    };

    # Icons
    icons = {
      enable = true;
      dark = iconThemeName;
      light = null;
      package = iconThemePkg;
    };

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
