{ pkgs, ... }:
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
  # Add installer script
  environment.etc."run-installer.sh" = {
    source = ./run-installer.sh;
    mode = "0755";
    user = "nixos";
    group = "nixos";
  };
}