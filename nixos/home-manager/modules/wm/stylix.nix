{ custom, config, lib, pkgs, ... }:
# Documentation: https://nix-community.github.io/stylix/options/platforms/nixos.html
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

  ### Fonts ###
  fontSizeSettings = {
    # TODO: Add options for application, desktop and popups
    applications = custom.font.default.size;
    desktop = custom.font.default.size;
    popups = custom.font.default.size;
    terminal = custom.font.terminal.size;
  };
  fontPackages = {
    "JetBrainsMono Nerd Font" = pkgs.nerd-fonts.jetbrains-mono;
    "Symbols Nerd Font" = pkgs.nerd-fonts.symbols-only;
    "Noto Color Emoji" = pkgs.noto-fonts-color-emoji;
  };
  mkFont = name: {
      inherit name;
      package = fontPackages.${name} or (throw "Unknown font: ${name}");
  };
  fontSettings = {
    # Todo: Add options for every font variant
    monospace = mkFont custom.font.default.name;
    sansSerif = mkFont custom.font.default.name;
    serif = mkFont custom.font.default.name;
    emoji = mkFont "Noto Color Emoji";
  };
in
lib.mkIf custom.gui.enable {
  ### Install fonts ###
  home.packages = builtins.attrValues fontPackages;
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
    override = {
      base00 = "121212";
    };
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
    fonts = {
      sizes = fontSizeSettings;
      # Variants
      monospace = fontSettings.monospace;
      sansSerif = fontSettings.sansSerif;
      serif = fontSettings.serif;
      emoji = fontSettings.emoji;
    };

    # Wallpaper image
    # image
    # imageScalingMode

    # Opacity
    # opacity.applications
    # opacity.desktop
    # opacity.popups
    opacity.terminal = 0.8;
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
