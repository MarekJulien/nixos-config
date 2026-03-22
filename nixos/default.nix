{ config, lib, pkgs, ... }:

{

  # systemd-boot
  boot.loader.systemd-boot.enable = true;
  boot.loader.grub.enable = false;

  # Set your time zone
  time.timeZone = "Europe/Berlin";

  # Select internationalisation properties
  console = {
    #font = "Lat2-Terminus16";
    keyMap = "de";
    #keyMapOptions = "caps:escape"; (wrong name / does not exist)
    #useXkbConfig = true; # use xkb.options in tty
  };

  # Enable flakes
  nix.extraOptions = "experimental-features = nix-command flakes";

  # State version
  system.stateVersion = "25.05"; # DO NOT CHANGE FOR ANY REASONS

}

