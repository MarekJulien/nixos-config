{ lib, custom, pkgs, ... }:

lib.mkIf custom.programs.groups.fun.enable {
  home.packages = with pkgs; [
    cmatrix
    cowsay
    fortune
    lolcat
    cbonsai
    figlet
    asciiquarium
    pipes
    sl
    hollywood
  ];
}
