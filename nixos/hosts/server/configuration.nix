{ config, pkgs, lib, ... }:

{
  networking.hostName = "server";
  imports = [
    ../../presets/server.nix
  ];
}
