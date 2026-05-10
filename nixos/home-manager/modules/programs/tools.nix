{ lib, custom, pkgs, ... }:
lib.mkIf custom.programs.groups.tools.enable {
  home.packages = with pkgs; [
    nmap
  ];
}
