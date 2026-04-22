{ self, lib, config, pkgs, ... }:

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
    pavucontrol # Audio controls
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
