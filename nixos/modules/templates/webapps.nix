{ config, lib, pkgs, ... }:

let
  apps = config.custom.webapps;

in {
  options.custom.webapps = lib.mkOption {
    type = lib.types.listOf lib.types.attrs;
    default = [];
  };

  config = {
    environment.systemPackages = map (app:
      let
        baseExec = "chromium --app=${app.url} --ozone-platform=wayland";

        exec =
          baseExec
          + (if app.incognito or false
            then " --incognito"
            else " --user-data-dir=/home/${config.custom.mainUser.username}/.webapp-data/${app.name}")
          + (if app.lightMode or false
            then ""
            else " --force-dark-mode --enable-features=WebUIDarkMode,WebContentsForceDark,WebUIDForceDark");

      in pkgs.makeDesktopItem {
        name = app.name;
        desktopName = app.name;
        exec = exec;
      }
    ) apps;
  };
}
