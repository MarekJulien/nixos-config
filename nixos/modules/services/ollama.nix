{ config, lib, ... }:

lib.mkIf config.custom.services.ollama.enable {
  services.ollama = {
    enable = true;
    host = "127.0.0.1";
    port = 11434;
  };
}
