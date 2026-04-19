{ lib, config, pkgs, ... }:

lib.mkIf config.custom.gui.enable {
  programs.hyprland = {
    enable = true;
    xwayland.enable = true;
  };

  environment.sessionVariables = {
    # If your cursor becomes invisible
    WLR_NO_HARDWARE_CURSORS = "1";
    # Hint electron apps to use wayland
    NIXOS_OZONE_WL = "1";
    # Stuff from https://discourse.nixos.org/t/hyprland-screen-sharing/43658
    XDG_CURRENT_DESKTOP = "Hyprland";
    XDG_SESSION_TYPE = "wayland";
    XDG_SESSION_DESKTOP = "Hyprland";
    MOZ_ENABLE_WAYLAND = "1";
    QT_QPA_PLATFORM = "wayland";
    GDK_BACKEND = "wayland";
    ELECTRON_ENABLE_WAYLAND = "1";
  };

  hardware = {
      graphics.enable = true;
      # Most wayland compositors need this
      #nvidia.modesetting.enable = true;
  };

  environment.systemPackages = with pkgs; [
    # rofi
    rofi-wayland
    # waybar
    waybar
    (waybar.overrideAttrs (oldAttrs: {
      mesonFlags = oldAttrs.mesonFlags ++ [ "-Dexperimental=true" ];
    })
    )
    # notification daemon
    dunst
    libnotify
    # wallpaper daemon
    swww
    # Clipboard
    wl-clipboard
  ];

  # TODO Clean solution
  # electron version fix
  nixpkgs.config.permittedInsecurePackages = [
    "electron-36.9.5"
  ];

  # TODO: Research
  xdg.portal = {
    enable = true;
    xdgOpenUsePortal = true;
    config = {
      common.default = ["gtk"];
      hyprland.default = ["gtk" "hyprland"];
    };
    extraPortals = [
      pkgs.xdg-desktop-portal-gtk
      pkgs.xdg-desktop-portal-wlr
      pkgs.xdg-desktop-portal-hyprland
    ];
  };

  # TODO Modularize
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    jack.enable = true;
    wireplumber.enable = true;
  };
}