{ lib, config, pkgs, ... }:

lib.mkIf config.custom.virtualisation.enable{
  virtualisation.libvirtd.enable = true;
  virtualisation.spiceUSBRedirection.enable = true;
  users.groups.libvirtd.members = ["${config.custom.mainUser.username}"];
  environment.systemPackages = with pkgs; [
    qemu
    virt-manager
  ];
}