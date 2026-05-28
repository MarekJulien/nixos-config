{ ... }:
{
  vim.git.enable = true;
  vim.filetree.nvimTree = {
    # Implementation: https://github.com/NotAShelf/nvf/blob/main/modules/plugins/filetree/nvimtree/nvimtree.nix
    enable = true;
    openOnSetup = false;
    mappings = {
      toggle = "<leader>tt";
      focus = "<leader>tz";
    };
    setupOpts = {
      view = {
        relativenumber = true;
        signcolumn = "auto";
      };
      ui = {
        confirm = {
          remove = true;
          trash = true;
        };
      };
      # Disable netrw
      disable_netrw = true;
      hijack_netrw = true;
      # Show diagnostics
      diagnostics = {
        enable = true;
        show_on_dirs = false;
        severity.min = "WARNING";
      };
      modified.enable = true;
      git.enable = true;
      renderer = {
        add_trailing = false; # Add / suffix to directories
        highlight_git = true;
        highlight_modified = "name";
        highlight_opened_files = "none";
        icons = {
          show = {
            folder = true;
            folder_arrow = false;
            git = true;
          };
          # one of "before", "after", "signcolumn", "right_align"
          diagnostics_placement="after";
          modified_placement = "after";
          git_placement="before";
          glyphs = {
            modified = "!";
            git = {
              deleted = "";
              ignored = "◌";
              renamed = "➜";
              staged = "✓";
              unmerged = "";
              unstaged = "✗";
              untracked = "★";
            };
          };
        };
      };
    };
  };
}
