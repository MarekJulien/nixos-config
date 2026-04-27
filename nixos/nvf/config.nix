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
      # Telescope 
      # > File search
      {
        mode = [ "n" ];
        key = "<leader>ff";
        action = "<cmd>Telescope find_files<CR>";
        desc = "Search files across the project";
      }
      {
        mode = [ "n" ];
        key = "<leader>fr";
        action = "<cmd>Telescope oldfiles<CR>";
        desc = "Search recently accessed files";
      }
      {
        mode = [ "n" ];
        key = "<leader>fb";
        action = "<cmd>Telescope buffers<CR>";
        desc = "Search open buffers";
      }
      # > Text search
      {
        mode = [ "n" ];
        key = "<leader>fg";
        action = "<cmd>Telescope live_grep<CR>";
        desc = "Search file content across the project";
      }
      {
        mode = [ "n" ];
        key = "<leader>fs";
        action = "<cmd>Telescope grep_string<CR>";
        desc = "Search for the word under cursor across the project";
      }
      # > Help
      {
        mode = [ "n" ];
        key = "<leader>fh";
        action = "<cmd>Telescope help_tags<CR>";
        desc = "Search Neovim help documentation (vim help tags)";
      }
      {
        mode = [ "n" ];
        key = "<leader>fk";
        action = "<cmd>Telescope keymaps<CR>";
        desc = "View keybindings";
      }
      {
        mode = [ "n" ];
        key = "<leader>fc";
        action = "<cmd>Telescope commands<CR>";
        desc = "Browse available Neovim commands";
      }
      # > Git
      {
        mode = [ "n" ];
        key = "<leader>fgc";
        action = "<cmd>Telescope git_commits<CR>";
        desc = "Browse Git commit history";
      }
      {
        mode = [ "n" ];
        key = "<leader>fgb";
        action = "<cmd>Telescope git_branches<CR>";
        desc = "List and switch Git branches";
      }
      {
        mode = [ "n" ];
        key = "<leader>fgs";
        action = "<cmd>Telescope git_status<CR>";
        desc = "View git status";
      }
    ];
    # Language support
    lsp.enable = true;
    languages = {
      enableTreesitter = true;
      enableFormat = false;
    }
    // mkLangs [ "nix" "bash" "assembly" "clang" "python" "html" "css" "typescript" "java" "lua" "sql"];
    # Plugins
    statusline.lualine.enable = true;
    telescope = {
      enable = true;
      setupOpts = {
        pickers.find_files.find_command = [
          "${pkgs.fd}/bin/fd"
          "--type=file"
          "--hidden"
          "--no-ignore"
        ];
      };
    };
    autocomplete.nvim-cmp.enable = true;
    git = {
      gitsigns.enable = true;
    };
  };
}
