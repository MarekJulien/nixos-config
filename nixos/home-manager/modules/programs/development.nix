{ lib, custom, pkgs, ... }:

lib.mkIf custom.programs.groups.developement.enable {
    home.packages = with pkgs; [
      # C
      gcc
      binutils
      gnumake
      # Python
      python3
      pipenv
      # Java
      jdk
      # NodeJS
      nodejs
    ]
    # GUI Editor
    ++ lib.optionals custom.gui.enable [
      vscodium
    ];
}
