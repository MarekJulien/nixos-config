{ self, lib, config, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    # Main
    bash
    vim
    zoxide
    git
    # Util / Tools
    fzf
    file
    zip unzip
    gnupg
    wget
    btop
    fastfetch # maintained neofetch alternative
    tree
    busybox
    cryptsetup
    ffmpeg
    ncdu
    gdu
    brightnessctl
    # Other, maybe deprecated
    libsecret # ???
    dconf # ???
  ]
  ++ lib.optionals config.custom.programs.tmux.enable [
    tmux
  ]
  ++ lib.optionals config.custom.programs.nvim.enable [
    self.packages.${pkgs.stdenv.hostPlatform.system}.nvf-neovim
    # Telescope dependecies
    ripgrep
    fd
  ];
}
