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
    neofetch
    tree
    busybox
    cryptsetup
    nmap
    ncdu
    gdu
    # Other, maybe deprecated
    flameshot # ???
    brightnessctl # still needed for hyprland?
    libsecret # ???
    dconf # ???
  ]
  ++ lib.optionals config.custom.programs.nvim.enable [
    self.packages.${pkgs.stdenv.hostPlatform.system}.nvf-neovim
    # Telescope dependecies
    ripgrep
    fd
  ];
}
