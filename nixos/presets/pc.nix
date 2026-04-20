{ lib, config, ... }:

{
  config.custom = {
    gui.enable = lib.mkDefault true;
    docker.enable = lib.mkDefault true;
    virtualisation.enable = lib.mkDefault true;
    programs.nvim.enable = true;
  };
}