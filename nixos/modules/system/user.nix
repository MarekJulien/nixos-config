{ config, pkgs, ... }:
{
  users.users.${config.custom.mainUser.username} = {
    isNormalUser = true;
    extraGroups = [ "wheel" ];
    shell = pkgs.bash;
  };
}
