{ lib, config, pkgs, ... }:

lib.mkIf config.custom.programs.groups.thm.enable {
  environment.systemPackages = with pkgs; [
    texliveFull
  ] ++ lib.optionals config.custom.programs.nvim.enable [
    element-desktop
    thunderbird
  ];
}
