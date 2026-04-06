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
    networkmanager # already included with networkmanager.enable option?
    git # maybe already included in nixos minimal installer
  ];
  # networkmanager / nmcli
  networking.wireless.enable = false;
  networking.networkmanager.enable = true;
  users.users.nixos.extraGroups = [ "networkmanager" ];
  # Add installer script
  environment.etc."run-installer.sh" = {
    source = ./run-installer.sh;
    mode = "0755";
    user = "nixos";
    group = "nixos";
  };
}