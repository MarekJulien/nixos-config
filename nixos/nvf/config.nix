# NVF neovim configuration
# https://github.com/NotAShelf/nvf
# https://nvf.notashelf.dev/options.html

{ ... }:
{
  imports = [
    ./plugins.nix
    ./lsp.nix
  ];
  vim = {
    # Theme   # TODO Set Theme (+transparent bg) with Stylix
    theme = {
      enable = true;
      name = "catppuccin";       # https://nvf.notashelf.dev/options.html#option-vim-theme-name
      style = "mocha";           # https://nvf.notashelf.dev/options.html#option-vim-theme-style
      transparent = true;
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
      wrap = true;
      breakindent = true;
      showbreak = "↪ ";
      ignorecase = true;
      smartcase = true;
      #cursorline = true; Does not look good with transparent background
      scrolloff = 10;
      list = true;
      confirm = true;
      mouse = ""; # Disable mouse inputs
    };
    # Disable arrow keys
    keymaps = [
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
  };
}
