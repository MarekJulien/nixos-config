{ config, ... }:

{
  # Options
  custom = {
    mainUser.username = "admin";
    services = {
      sshServer.enable = true;
      tor = {
        enable = true;
        hiddenServices = {
          ssh.enable = true;
        };
      };
    };
  };
  # Config
  users.users.${config.custom.mainUser.username}.initialPassword = "changeme!"; # Initial password for vm tests
}
