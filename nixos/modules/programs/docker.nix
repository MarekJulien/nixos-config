{config, ...}:
{
  virtualisation.docker = {
    enable = true;
    rootless.enable = true;
    enableOnBoot = true;
    daemon.settings = {
      dns = [ "1.1.1.1" "9.9.9.9" ];
      ipv6 = false;
    };
  };
  users.users.${config.mainUser.username}.extraGroups = [ "docker" ];
}