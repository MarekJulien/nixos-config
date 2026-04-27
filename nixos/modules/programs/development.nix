{ lib, config, pkgs, ... }:

lib.mkIf config.custom.programs.groups.developement.enable {
    environment.systemPackages = with pkgs; [
      # NodeJS
      nodejs
      # Java
      jdk
      # C
      gcc
      binutils
      gnumake
    ]
    # GUI Editor
    ++ lib.optionals config.custom.gui.enable [
      vscodium
    ];
}
