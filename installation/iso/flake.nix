{
  description = "NixOS installation ISO";
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-25.05";
    configrepo = {
      url = "github:MarekJulien/nixos-config";
      flake = false;
    };
  };
  outputs = inputs@{ nixpkgs, configrepo, ... }: {
    nixosConfigurations.iso = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      specialArgs = {
        inherit configrepo;
      };
      modules = [
        "${nixpkgs}/nixos/modules/installer/cd-dvd/installation-cd-minimal.nix"
        ./config.nix
      ];
    };
  };
}