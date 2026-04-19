{ lib, config, ... }:

lib.mkIf config.custom.services.sshServer.enable {
  services.openssh = {
    enable = true;
    ports = [ config.custom.services.sshServer.port ];
    settings = {
      PermitRootLogin = "no";
      PasswordAuthentication = false;
      PubkeyAuthentication = true;
      X11Forwarding = false;
      MaxAuthTries = 3;
      LoginGraceTime = 30;
      ClientAliveInterval = 300;
      ClientAliveCountMax = 3;
    };
  };

  networking.firewall = {
    allowedTCPPorts = [ config.custom.services.sshServer.port ];
  };

  users.users.${config.custom.mainUser.username} = {
    openssh.authorizedKeys.keys = [
      config.custom.services.sshServer.pubAuthKey
    ];
  };

  services.fail2ban.jails.sshd.settings = {
    enabled = true;
    maxretry = 5;
    bantime = "-1"; # permanent
  };
}