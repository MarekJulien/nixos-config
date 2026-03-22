{ pkgs, ... }:

{
    environment.systemPackages = with pkgs; [
      # Terminal
      alacritty
      bash
      fzf
      vim
      # Other
      pcmanfm
      flameshot
      brightnessctl
      libsecret # ???
      dconf # ???
    ];
}
