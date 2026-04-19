{ ... }:

{
  networking.hostName = "laptop";
  imports = [
    ../../presets/pc.nix
  ];
}