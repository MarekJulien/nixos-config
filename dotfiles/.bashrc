# Commands that should be applied only for interactive shells.
[[ $- == *i* ]] || return

export PS1='\[\e[92;1m\]\u\[\e[22;2;2m\]@\H\[\e[0m\]:\[\e[93;1m\]\w\[\e[0m\]'
if [ -n "$IN_NIX_SHELL" ]; then
  PS1="$PS1 (nix-shell)"
fi
PS1="$PS1 \$ "

# History options
HISTSIZE=10000
HISTFILESIZE=10000
HISTFILE=~/.bash_history
shopt -s histappend
HISTCONTROL=ignorespace:erasedups # ignore commands with leading space, ignore duplicats
HISTIGNORE='ls:ll:la:pwd:clear:history:exit' # ignore common noise commands
PROMPT_COMMAND='history -a; history -n'

shopt -s checkwinsize
shopt -s extglob
shopt -s globstar
shopt -s checkjobs

# Aliases
alias cd="z"
alias ls="ls --color"
alias la="ls -a"
alias neofetch="fastfetch"
alias init-git="git init && touch README.md && touch .gitignore && git add -A && git commit -m 'Initial commit'"
alias devshell="nix-shell --run bash"
alias fetch-and-rebuild-flake="cd ~/nixos-config/nixos && git pull && sudo nixos-rebuild switch --flake .#$NIX_FLAKE_HOST"

# Functions
mkdircd() {
  mkdir "$1" && cd "$1"
}
init-nixshell() {
  if [ -e shell.nix ]; then
      echo "shell.nix already present"
      return
  fi
  cat <<EOF > shell.nix
{ pkgs ? import <nixpkgs> {} }:
pkgs.mkShell {
  buildInputs = with pkgs; [
    
  ];
}
EOF
  echo "shell.nix created"
}
init-nixdev() {
  if [ -e flake.nix ]; then
    echo "flake.nix already present"
    return
  fi
  cat <<EOF > flake.nix
{
  description = "Nix dev shell";
  inputs.nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
  outputs = { self, nixpkgs }:
  let
    system = "x86_64-linux";
    pkgs = import nixpkgs {
      inherit system;
      # config.allowUnfree = true;
    };
  in {
    devShells.\${system}.default = pkgs.mkShell {
      buildInputs = with pkgs; [
        
      ];
      shellHook = ''
        source ~/.bashrc # TODO clean solution
      '';
    };
  };
}
EOF
  echo "flake.nix created"
}
test-pkgs() {
  nix-shell --run bash -p "$@"
}
clear-trash() {
  local trash
  trash="$HOME/.local/share/Trash"
  local size
  size=$(du -sh "$trash" | cut -f1)
  rm -rf "$trash"/{files,info}/*
  echo "Cleared $size"
}
print-files-as-llm-context() {
  local path
  local all_valid=0
  # Check if all paths are valid files
  for path in "$@"; do
    if [[ ! -f "$path" ]]; then
      echo "\"$path\" is not a valid file"
      all_valid=1
    fi
  done
  # Print files
  [ "$all_valid" -ne 0 ] && return 1
  for path in "$@"; do
    printf "file \"%s\":\n" "$path"
    printf "´´´\n"
    cat "$path"
    printf "´´´\n"
    printf "\n"
  done
}

# Zoxide integration
eval "$(zoxide init bash)"

