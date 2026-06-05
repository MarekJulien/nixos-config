{ pkgs, ... }:
{
  environment.systemPackages = [ pkgs.man-pages ];
  documentation = {
    dev.enable = true;
    man.cache.enable = true;
    # nixos.includeAllModules = true;
  };
}
