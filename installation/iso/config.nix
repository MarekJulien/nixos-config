{ pkgs, configrepo, ... }:
{
  # Set time zone
  time.timeZone = "Europe/Berlin";
  # Set keyboard layout
  console = {
    keyMap = "de";
  };
  # Enable flakes
  nix.extraOptions = "experimental-features = nix-command flakes";
  # State version
  system.stateVersion = "25.05";
  # Add config repo
  system.activationScripts.copyRepo.text = ''
    mkdir -p /home/nixos/nixos-config
    cp -r ${configrepo}/* /home/nixos/nixos-config/
    chown -R nixos:nixos /home/nixos/nixos-config
  '';
}