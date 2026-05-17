{ lib, custom, ... }:
lib.mkIf custom.gui.enable {
  programs.alacritty = {
    enable = true;
    settings = {
      # Opacity, colors/theme and font is set by stylix
      window = {
        dynamic_padding = true;
        padding = {
          x = 6;
          y = 6;
        };
      };
    };
  };
}
