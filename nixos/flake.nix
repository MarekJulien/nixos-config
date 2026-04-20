{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-25.05";
    nvf = {
      url = "github:NotAShelf/nvf";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };
  outputs = inputs@{ nixpkgs, nvf, self, ... }:
    let
      system = "x86_64-linux";
      mkHost = host: nixpkgs.lib.nixosSystem {
        inherit system;
        specialArgs = { inherit inputs; inherit self; };
        modules = [
          ./default.nix
          ./hosts/${host}/configuration.nix
          ./hosts/${host}/hardware-configuration.nix
        ];
      };
    in {
      nixosConfigurations = {
        desktop = mkHost "desktop";
        laptop = mkHost "laptop";
        server = mkHost "server";
      };
      # NVF
      packages.x86_64-linux.nvf-neovim =
      (nvf.lib.neovimConfiguration {
        pkgs = nixpkgs.legacyPackages.x86_64-linux;
        modules = [
          ./nvf/config.nix
        ];
      }).neovim;
    };
}