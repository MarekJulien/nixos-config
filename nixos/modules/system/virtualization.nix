{ config, pkgs, ... }:
{
  virtualisation.libvirtd.enable = true;
  virtualisation.spiceUSBRedirection.enable = true;
  users.groups.libvirtd.members = ["${config.mainUser.username}"];
  environment.systemPackages = with pkgs; [
    qemu
    virt-manager
  ];
}