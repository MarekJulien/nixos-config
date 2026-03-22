{ pkgs, ... }:
{
  programs.hyprland = {
  enable = true;
  nvidiaPatches = true;
  xwayland.enable = true;
  };

  environment.sessionVariables = {
    # If your cursor becomes invisible
    WLR_NO_HARDWARE_CURSORS = "1";
    # Hint electron apps to use wayland
    NIXOS_OZONE_WL = "1";
  };

  hardware = {
      # Opengl
      opengl.enable = true;
      # Most wayland compositors need this
      nvidia.modesetting.enable = true;
  };

  environment.systemPackages = with pkgs; [
    # default terminal emulator
    kitty
    # app launcher
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
  ];

  # TODO: Research
  xdg.portal.enable = true;
  xdg.portal.extraPortals = [ pkgs.xdg-desktop-portal-gtk ];

  # TODO Modularize
  # Sound
  sound.enable = true;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    jack.enable = true;
  };

}