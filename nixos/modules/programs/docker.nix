{config, ...}:
{
  virtualisation.docker.enable = true;
  virtualisation.docker.enableOnBoot = true;
  users.users.${config.mainUser.username}.extraGroups = [ "docker" ];
}