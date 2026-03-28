{ pkgs, ... }:

{
    environment.systemPackages = with pkgs; [
      # General
      git
      gh
      vscodium
      # NodeJS
      nodejs
      # Java
      jdk
      # C
      gcc
      binutils
      gnumake
      # API tests
      bruno
    ];
}
