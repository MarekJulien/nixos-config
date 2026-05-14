{ lib, flakeRoot, custom, pkgs, ... }:
let
  # Config files dir
  waybarFiles = "${flakeRoot}/../config-files/waybar";
  # Waybar modules & conf
  wbConfig = builtins.fromJSON (builtins.readFile "${waybarFiles}/config");
  wbModules = builtins.fromJSON (builtins.readFile "${waybarFiles}/modules.json");
  # Waybar style/css
  cssContent = builtins.readFile "${waybarFiles}/style.css";
  cssLines = lib.splitString "\n" cssContent;
  # > filter out manually defined fallback base colors (stylix colors get injected later)
  filteredCssLines = builtins.filter (line: !(lib.hasPrefix "@define-color base" line)) cssLines;
  # > build style string
  wbStyle = lib.concatStringsSep "\n" filteredCssLines;
in
lib.mkIf custom.gui.enable {
  home.packages = with pkgs; [
    waybar
  ];
  programs.waybar = {
    enable = true;
    systemd.enable = false; # compatible with home-manager?
    settings.mainBar = wbConfig // wbModules;
    style = wbStyle;
  };
}
