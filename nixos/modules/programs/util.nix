{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    file
    zip
    unzip
    gnupg
    wget
    btop
    neofetch
    tree
    busybox
    cryptsetup
    vlc
    nmap
    ncdu
    gdu
    git
  ];
}
