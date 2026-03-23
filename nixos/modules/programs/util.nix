{ pkgs, ... }:

{
    environment.systemPackages = with pkgs; [
      file
      zip
      unzip
      gnupg
      copyq
      xclip
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
    ];
}
