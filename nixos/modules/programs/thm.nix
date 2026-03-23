{ pkgs, ... }:

{
    environment.systemPackages = with pkgs; [
      element-desktop
      thunderbird
      texliveFull
      #processing
      #R
      #rstudio
    ];
}
