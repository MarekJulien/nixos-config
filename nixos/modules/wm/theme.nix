{ inputs, lib, config, pkgs, ... }:

{
  imports = [
    inputs.stylix.nixosModules.stylix
  ];
  stylix = lib.mkIf config.custom.gui.enable {
    enable = true;
    # Set system wide color scheme (https://tinted-theming.github.io/tinted-gallery/)
    base16Scheme = "${pkgs.base16-schemes}/share/themes/colors.yaml";
  };
}
