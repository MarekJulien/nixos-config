# Commands that should be applied only for interactive shells.
[[ $- == *i* ]] || return

export PS1='\[\e[92;1m\]\u\[\e[22;2;2m\]@\H\[\e[0m\]:\[\e[93;1m\]\w\[\e[0m\]'
if [ -n "$IN_NIX_SHELL" ]; then
  PS1="$PS1 (nix-shell)"
fi
PS1="$PS1 \$ "

# History options
HISTSIZE=10000
HISTFILESIZE=100000
HISTFILE=~/.bash_history
shopt -s histappend
HISTCONTROL=ignorespace:erasedups # ignore commands with leading space, ignore duplicats
HISTIGNORE='ls:ll:la:pwd:clear:history:exit' # ignore common noise commands
PROMPT_COMMAND='history -a; history -n'

shopt -s checkwinsize
shopt -s extglob
shopt -s globstar
shopt -s checkjobs

# Aliases & Functions
# > dev
alias g="git"
alias init-git="git init && touch README.md && touch .gitignore && git add -A && git commit -m 'Initial commit'"
alias devshell="nix-shell --run bash"
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
# > terminal / navigation
alias cd="z"
alias ls="ls --color"
alias la="ls -a"
mkcd() {
  mkdir "$1" && cd "$1"
}
# > NixOS
alias list-nixos-generations="sudo nix-env -p /nix/var/nix/profiles/system --list-generations"
switch-nixos-generation() {
  if [ -z "$1" ]; then
    echo "Usage: list-nixos-generations <generation-number>"
    return 1
  fi
  local GENERATION_LINK="/nix/var/nix/profiles/system-${1}-link"
  if [ ! -e "$GENERATION_LINK" ]; then
    echo "Generation ${1} not available"
    return 2
  fi
  sudo "$GENERATION_LINK"/bin/switch-to-configuration switch
}
delete-old-nixos-generations() {
  read -r -p "This will delete every generation except the current one and make rollbacks impossible. Continue? [y/N] " answer
  if [[ "${answer,,}" =~ ^(y|yes)$ ]]; then
    sudo nix-collect-garbage -d
    nix-collect-garbage -d
  else
    echo "Canceled"
  fi
}
test-pkgs() {
  nix-shell --run bash -p "$@"
}
alias fetch-and-rebuild-flake="cd ~/nixos-config/nixos && git pull && sudo nixos-rebuild switch --flake .#$NIX_FLAKE_HOST"
# > LLM
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
# > etc
alias neofetch="fastfetch"
clear-trash() {
  local trash
  trash="$HOME/.local/share/Trash"
  local size
  size=$(du -sh "$trash" | cut -f1)
  rm -rf "$trash"/{files,info}/*
  echo "Cleared $size"
}


# Zoxide integration
eval "$(zoxide init bash)"

