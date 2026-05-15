{ lib, config, pkgs, ... }:
# Documentation: https://github.com/apognu/tuigreet
let
  theme = custom-theme;
  width = 80;
  # Themes
  no-theme = {
    base00 = "";
    base01 = "";
    base02 = "";
    base03 = "";
    base04 = "";
    base05 = "";
    base06 = "";
    base07 = "";
    base08 = "";
    base09 = "";
    base0A = "";
    base0B = "";
    base0C = "";
    base0D = "";
    base0E = "";
    base0F = "";
  };
  custom-theme = {
    base00 = "";
    base01 = "darkgray";    # text
    base02 = "";
    base03 = "darkgray";    # border, container
    base04 = "";
    base05 = "";
    base06 = "";
    base07 = "gray";        # input
    base08 = "";
    base09 = "lightgray";   # promt
    base0A = "";
    base0B = "";
    base0C = "gray";        # action
    base0D = "darkgray";    # button
    base0E = "gray";        # time
    base0F = "";
  };
  # tuigreed does not support hex colors :(
  catppuccin-mocha = {
    base00 = "#1e1e2e";
    base01 = "#181825";
    base02 = "#313244";
    base03 = "#45475a";
    base04 = "#585b70";
    base05 = "#cdd6f4";
    base06 = "#f5e0dc";
    base07 = "#b4befe";
    base08 = "#f38ba8";
    base09 = "#fab387";
    base0A = "#f9e2af";
    base0B = "#a6e3a1";
    base0C = "#94e2d5";
    base0D = "#89b4fa";
    base0E = "#cba6f7";
    base0F = "#f2cdcd";
  };
in
lib.mkIf config.custom.gui.enable {
  services.greetd = {
    enable = true;
    settings = {
      default_session = {
        command = ''${pkgs.tuigreet}/bin/tuigreet \
          --cmd start-hyprland \
          --greeting "$(${pkgs.fortune}/bin/fortune -n ${toString (width - 10)} -s)" \
          --greet-align center \
          --width ${toString width} \
          --remember \
          --time \
          --theme "border=${theme.base03};text=${theme.base01};prompt=${theme.base09};time=${theme.base0E};action=${theme.base0C};button=${theme.base0D}container=${theme.base03};input=${theme.base07}"
        '';
        user = "greeter";
      };
    };
  };
  # Keyring
  services.gnome.gnome-keyring.enable = true;
  security.pam.services.greetd.enableGnomeKeyring = true;
}
