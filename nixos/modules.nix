{ lib, ... }:

let
  module-path = ./modules;
  # List all module categories
  categories = builtins.attrNames (builtins.readDir module-path);
  nixFilesIn = dir:
    let all = builtins.attrNames (builtins.readDir ("${module-path}/${dir}"));
    in lib.filter (f: builtins.match ".+\\.nix$" f != null) all;
  # Iterate and collect all module files
  nixosModulePaths = lib.concatMap
  (category: lib.map (file: "${module-path}/${category}/${file}") (nixFilesIn category))
  categories;
in
{
  imports = nixosModulePaths;
}