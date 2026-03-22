{ pkgs, ... }:

{
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
