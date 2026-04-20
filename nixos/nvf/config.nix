# NVF neovim configuration
# https://github.com/NotAShelf/nvf
# https://nvf.notashelf.dev/options.html

{ pkgs, ... }:
let
  mkLangs = langs:
    builtins.listToAttrs (map (l: {
      name = l;
      value = { enable = true; };
    }) langs);
in
{
  config.vim = {
    # Theme
    theme = {
      enable = true;
      name = "github"; # https://nvf.notashelf.dev/options.html#option-vim-theme-name
      style = "dark_high_contrast";   # https://nvf.notashelf.dev/options.html#option-vim-theme-style
    };
    # Vim settings
    options = {
      number = true;
      relativenumber = true;
      tabstop = 2;
      shiftwidth = 2;
      expandtab = true;
    };
    # Language support
    lsp.enable = true;
    languages = {
      enableTreesitter = true;
      enableFormat = false;
    }
    // mkLangs [ "nix" "bash" "assembly" "clang" "python" "html" "css" "typescript" "java" "lua" "sql"];
    # Other
    statusline.lualine.enable = true;
    telescope.enable = true;
    autocomplete.nvim-cmp.enable = true;
  };
}
