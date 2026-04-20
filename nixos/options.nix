{ config, lib, ...}:

{
  options.custom = {
    mainUser = {
      username = lib.mkOption {
        default = "beaver";
      };
    };
    sudoTimeoutMinutes = lib.mkOption {
      type = lib.types.int;
      default = 15;
    };
    programs = {
      nvim.enable = lib.mkEnableOption "nvim";
    };
    gui = {
      enable = lib.mkEnableOption "GUI";
      cursor = {
        size = lib.mkOption {
          type = lib.types.int;
          default = 20;
        };
        theme = lib.mkOption {
          type = lib.types.str;
          default = "Bibata-Modern-Classic";
        };
      };
    };
    docker.enable = lib.mkEnableOption "Docker";
    virtualisation.enable = lib.mkEnableOption "Virtualisation";
    services = {
      sshServer = {
        enable = lib.mkEnableOption "SSH Server";
        port = lib.mkOption {
          type = lib.types.int;
          default = 30002;
        };
        pubAuthKey = lib.mkOption {
          type = lib.types.str;
          default = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIAw6yKzBcdtFVuyhCqOj8ZenIlKx73bP3XcRm6FCdRU5";
        };
      };
    };
  };
}