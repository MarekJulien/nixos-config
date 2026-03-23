{ config, pkgs, lib, ... }:
{
  options.mainUser = {
    username = lib.mkOption {
      default = "beaver";
    };
  };

  config = {
    programs.zsh.enable = true;
    users.users.${config.mainUser.username} = {
      isNormalUser = true;
      extraGroups = [ "wheel" ];
      shell = pkgs.bash;
    };
  };
}
