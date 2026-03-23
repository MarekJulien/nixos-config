{ pkgs, ... }:

{
  networking.networkmanager.enable = true;
  users.users.beaver.extraGroups = [ "networkmanager" ];
  environment.systemPackages = with pkgs; [
    networkmanagerapplet
  ];
}