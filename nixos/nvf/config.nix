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
      name = "github";                # https://nvf.notashelf.dev/options.html#option-vim-theme-name
      style = "dark_high_contrast";   # https://nvf.notashelf.dev/options.html#option-vim-theme-style
    };
    # Globals
    globals = {
      mapleader = " ";
    };
    # Options
    options = {
      number = true;
      relativenumber = true;
      tabstop = 2;
      shiftwidth = 2;
      expandtab = true;
      ignorecase = true;
      smartcase = true;
      cursorline = true;
      scrolloff = 10;
      list = true;
      confirm = true;
    };
    # Keymaps
    keymaps = [
      # Disable arrow keys
      {
        mode = [ "n" "i" "v" ];
        key = "<Up>";
        action = "<Nop>";
      }
      {
        mode = [ "n" "i" "v" ];
        key = "<Down>";
        action = "<Nop>";
      }
      {
        mode = [ "n" "i" "v" ];
        key = "<Left>";
        action = "<Nop>";
      }
      {
        mode = [ "n" "i" "v" ];
        key = "<Right>";
        action = "<Nop>";
      }
    ];
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
