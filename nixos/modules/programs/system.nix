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
      brightnessctl
      libsecret # ???
      dconf # ???
    ];
}
