{ inputs, flakeRoot, config, pkgs, ... }:
let
  sopsKeyFile = "${config.custom.mainUser.keyDir}/sops/age/keys.txt";
in
{
  imports = [
    inputs.sops-nix.nixosModules.sops
  ];
  sops.defaultSopsFile = flakeRoot + "/secrets/secrets.yaml";
  sops.defaultSopsFormat = "yaml";
  sops.age.keyFile = sopsKeyFile;
  environment.variables = {
    SOPS_AGE_KEY_FILE = sopsKeyFile;
  };
  # Secrets
  sops.secrets = {
    
  };
  # Install sops for editing
  environment.systemPackages = with pkgs; [
    sops
  ];
}
