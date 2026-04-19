{ config, pkgs, ... }:

{
  networking.networkmanager.enable = true;
  users.users.${config.custom.mainUser.username}.extraGroups = [ "networkmanager" ];
  
  environment.systemPackages = with pkgs;
  lib.optionals config.custom.gui.enable [
      pkgs.networkmanagerapplet
  ];

  networking.firewall = {
    enable = true;
  };
}