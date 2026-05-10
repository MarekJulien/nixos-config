{ lib, ... }:

{
  custom = {
    gui.enable = lib.mkDefault true;
    docker.enable = lib.mkDefault true;
    virtualisation.enable = lib.mkDefault true;
    programs = {
      groups = {
        developement.enable = true;
        thm.enable = true;
        fun.enable = true;
        tools.enable = true;
      };
      nvim.enable = true;
    };
    services = {
      ollama.enable = true;
    };
  };
}
