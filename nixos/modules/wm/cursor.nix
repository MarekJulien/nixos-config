# This module should be migrated to home-manager Stylix, but this has not worked so far
{ lib, config, ... }:
let
  cursorSize = config.custom.gui.cursor.size;
in
{
  config = lib.mkIf config.custom.gui.enable {
    environment.variables = {
      XCURSOR_SIZE = toString cursorSize;
    };
  };
}
