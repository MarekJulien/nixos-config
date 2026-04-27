{ lib, config, pkgs, ... }:

lib.mkIf config.custom.programs.groups.fun.enable {
  environment.systemPackages = with pkgs; [
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
