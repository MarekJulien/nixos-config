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
      ${config.custom.mainUser.username} = import ./home-manager/mainUser.nix;
    };
  };
}
