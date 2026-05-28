{ ... }:
let
  mkLangs = langs:
    builtins.listToAttrs (map (l: {
      name = l;
      value = { enable = true; };
    }) langs);
in
{
  vim = {
    # Diagnostics
    diagnostics = {
      enable = true;
      config = {
        virtual_text = false;
        virtual_lines = true;
      };
    };
    # Language support
    lsp.enable = true;
    languages = {
      enableTreesitter = true;
      enableFormat = false;
    }
    // mkLangs [ "nix" "bash" "assembly" "clang" "make" "python" "html" "css" "typescript" "java" "json" "yaml" "lua" "sql" "tex"];
  };
}
