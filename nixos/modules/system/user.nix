{ config, pkgs, ... }:
{

  users.users.${config.custom.mainUser.username} = {
    isNormalUser = true;
    createHome = true;
    extraGroups = [ "wheel" ];
    shell = pkgs.bash;
  };

  security.sudo.extraConfig = ''
    Defaults timestamp_timeout=${toString config.custom.sudoTimeoutMinutes}
  '';

}
