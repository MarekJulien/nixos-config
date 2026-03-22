{ lib }:

let
  # List all module categories
  categories = builtins.attrNames (builtins.readDir .);
  # Function to list all *.nix files in a given directory
  nixFilesIn = dir:
    let all = builtins.attrNames (builtins.readDir (./${dir}));
    in lib.filter (f: builtins.match ".+\\.nix$" f != null) all;
  # Iterate and collect all module files
  nixosModulePaths = lib.concatMap
  (category: lib.map (file: ./${category}/${file}) (nixFilesIn category))
  categories;
in
{
  imports = nixosModulePaths;
}