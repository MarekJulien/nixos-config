{ config, ... }:

{
  config.custom = {
    mainUser.username = "admin";
    services.sshServer.enable = true;
  };
}