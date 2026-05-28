{ ... }:
let
  plugin-path = ./plugins;
  plugins-configs = builtins.map
    (name: plugin-path + "/${name}")
    (builtins.attrNames (builtins.readDir "${plugin-path}"));
in
{
  # Import "big" plugin configurations
  imports = plugins-configs;
  # Enable one liners
  vim = {
    utility.smart-splits.enable = true; # vim/tmux integration
    statusline.lualine.enable = true;
    # autocomplete.nvim-cmp.enable = true;
    git = {
      gitsigns.enable = true;
    };
    utility.motion.flash-nvim.enable = true; # Navigation
    visuals = {
      fidget-nvim.enable = true; # LSP UI
      nvim-web-devicons.enable = true; # file icons
    };
    comments.comment-nvim.enable = true; # Comments
    autopairs.nvim-autopairs.enable = true; # (){}... autoclose
  };
}

