{ lib, config, pkgs, ... }:
lib.mkIf config.custom.programs.groups.tools.enable {
  programs.wireshark.enable = true;
  users.users.${config.custom.mainUser.username}.extraGroups = [ "wireshark" ];
  environment.systemPackages = with pkgs; [
    wireshark
  ];
}
