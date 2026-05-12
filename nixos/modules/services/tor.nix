{ lib, config, ... }:
let
  torcfg = config.custom.services.tor;
in
lib.mkIf torcfg.enable {
  services.tor = {
    enable = true;
    relay.onionServices =
      (lib.optionalAttrs torcfg.hiddenServices.ssh.enable {
        ssh = {
          version = 3;
          # privateKeyFile = "${builtins.toString config.custom.mainUser.keyDir}/tor/onion-services/ssh/pk"; # TODO
          map = [
            {
              port = torcfg.hiddenServices.ssh.hiddenPort;
              target = {
                addr = "127.0.0.1";
                port = config.custom.services.sshServer.port;
              };
            }
          ];
        };
      });
  };
}
