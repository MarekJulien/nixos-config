{ lib, custom, pkgs, ... }:

lib.mkIf custom.programs.groups.thm.enable {
  home.packages = with pkgs; [
    texliveFull
  ] ++ lib.optionals custom.programs.groups.thm.enable [
    element-desktop
    thunderbird
  ];
}
