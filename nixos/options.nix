{ lib, config, ...}:

{
  options.custom = {
    mainUser = {
      username = lib.mkOption {
        type = lib.types.str;
        default = "beaver";
      };
      homeDir = lib.mkOption {
        type = lib.types.path;
        default = builtins.toPath "/home/${config.custom.mainUser.username}";
      };
      keyDir = lib.mkOption {
        type = lib.types.path;
        default = builtins.toPath "${config.custom.mainUser.homeDir}/keys";
      };
    };
    sudoTimeoutMinutes = lib.mkOption {
      type = lib.types.int;
      default = 15;
    };
    defaultApplications = {
      editor = lib.mkOption {
        type = lib.types.str;
        default = "vim";
      };
    };
    programs = {
      groups = {
        developement.enable = lib.mkEnableOption "developement programs";
        thm.enable = lib.mkEnableOption "thm programs";
        fun.enable = lib.mkEnableOption "fun programs";
        tools.enable = lib.mkEnableOption "tool programs";
      };
      nvim.enable = lib.mkEnableOption "nvim";
      tmux.enable = lib.mkEnableOption "tmux";
    };
    util = {
      pipewire.enable = lib.mkEnableOption "pipewire";
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
      iconTheme = lib.mkOption {
        type = lib.types.str;
        default = "Papirus";
      };
    };
    docker.enable = lib.mkEnableOption "Docker";
    virtualisation.enable = lib.mkEnableOption "Virtualisation";
    services = {
      sshServer = {
        enable = lib.mkEnableOption "SSH Server";
        port = lib.mkOption {
          type = lib.types.int;
          default = 22;
        };
        pubAuthKey = lib.mkOption {
          type = lib.types.str;
          default = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIAw6yKzBcdtFVuyhCqOj8ZenIlKx73bP3XcRm6FCdRU5";
        };
      };
      tor = {
        enable = lib.mkEnableOption "tor service";
        hiddenServices = {
          ssh = {
            enable = lib.mkEnableOption "Hidden ssh service";
            hiddenPort = lib.mkOption {
              type = lib.types.int;
              default = 30001;
            };
          };
        };
      };
      ollama = {
        enable = lib.mkEnableOption "Ollama service";
      };
    };
  };
}
