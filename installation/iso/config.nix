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
  # Additional programs
  environment.systemPackages = with pkgs; [
    networkmanager #nmcli
    git #maybe already included in nixos minimal installer
  ];
  # Add installer script
  environment.etc."run-installer.sh" = {
    source = ./run-installer.sh;
    mode = "0755";
    user = "nixos";
    group = "nixos";
  };
}