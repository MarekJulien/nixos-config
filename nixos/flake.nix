{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    stylix = {
      url = "github:nix-community/stylix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nvf = {
      url = "github:NotAShelf/nvf";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    sops-nix = {
      url = "github:Mic92/sops-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };
  outputs = inputs@{ self, nixpkgs, ... }:
    let
      system = "x86_64-linux";
      mkHost = host: nixpkgs.lib.nixosSystem {
        inherit system;
        specialArgs = {
          inherit inputs self system;
          flakeRoot = self;
        };
        modules = [
          ./default.nix
          ./hosts/${host}/configuration.nix
          ./hosts/${host}/hardware-configuration.nix
          ./home-manager.nix
          ({
            environment.variables = {
              NIX_FLAKE_HOST = host;
            };
            networking.hostName = host;
          })
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
      (inputs.nvf.lib.neovimConfiguration {
        pkgs = nixpkgs.legacyPackages.x86_64-linux;
        modules = [
          ./nvf/config.nix
        ];
      }).neovim;
    };
}
