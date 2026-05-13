{ inputs, config, ... }:
{
  imports = [
    inputs.home-manager.nixosModules.home-manager
  ];
  home-manager = {
    extraSpecialArgs = {
      inherit inputs;
      inherit (config) custom;
    };
    users = {
      ${config.custom.mainUser.username} = {
        imports = [
          inputs.stylix.homeModules.stylix
          ./home-manager/mainUser.nix
        ];
      };
    };
  };
}
