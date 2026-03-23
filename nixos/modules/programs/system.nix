{ pkgs, ... }:

{
    environment.systemPackages = with pkgs; [
      # Terminal
      alacritty
      bash
      fzf
      vim
      # Other
      zoxide
      pcmanfm
      flameshot
      brightnessctl # still needed for hyprland?
      libsecret # ???
      dconf # ???
    ];
}
