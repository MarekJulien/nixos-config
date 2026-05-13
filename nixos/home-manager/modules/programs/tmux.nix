{ lib, custom, pkgs, ... }:
lib.mkIf custom.programs.tmux.enable {
  programs.tmux = {
    enable = true;
    # Plugins
    plugins = with pkgs; [
      tmuxPlugins.sensible
      tmuxPlugins.vim-tmux-navigator
      # Stylix sets theme
      # {
      #   plugin = tmuxPlugins.catppuccin;
      #   extraConfig = ''
      #     set -g @catppuccin_flavour 'mocha'
      #   '';
      # }
    ];
    # Config
    mouse = false;
    clock24 = true;
    keyMode = "vi";
    # prefix = "C-Space";
    shortcut = "Space"; # Short variant for prefix = "C-{}"
    baseIndex = 1;
    disableConfirmationPrompt = true; # e.g. when closing a window or pane
    historyLimit = 10000;
    sensibleOnTop = true; # Run sensible plugin first
    extraConfig = ''
      # set-option -sa terminal-overrides ",xterm*:Tc" # ???
      # Split using cwd
      bind '"' split-window -v -c "#{pane_current_path}"
      bind % split-window -h -c "#{pane_current_path}"
    '';
  };
}
