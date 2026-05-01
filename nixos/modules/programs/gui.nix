{ lib, config, pkgs, ... }:

lib.mkIf config.custom.gui.enable {
    environment.systemPackages = with pkgs; [
      alacritty
      brave
      keepassxc
      gimp
      libreoffice
      pcmanfm
      vlc
      # Webapp launcher
      chromium
    ];
    # Webapps
    custom.webapps = [
      {
        name = "ChatGPT";
        url = "https://chat.openai.com";
        incognito = true;
      }
      {
        name = "Discord";
        url = "https://discord.com/app";
        incognito = false;
      }
      {
        name = "RelentChess";
        url = "https://relentchess.pixel-cursor.com";
        incognito = false;
      }
    ];
}
