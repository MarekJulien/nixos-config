{ ... }:

{
  networking.hostName = "desktop";
  imports = [
    ../../presets/pc.nix
  ];
}