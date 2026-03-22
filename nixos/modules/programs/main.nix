{ pkgs, ... }:

{
    environment.systemPackages = with pkgs; [
      brave
      keepassxc
      gimp
      libreoffice
      vesktop
    ];
}
