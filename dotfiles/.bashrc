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
alias init-git="git init && touch README.md && touch .gitignore && git add -A && git commit -m 'Initial commit'"
alias devshell="nix-shell --run bash"

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
test-pkgs() {
  nix-shell --run bash -p "$@"
}
clear-trash() {
  local TRASH="$HOME/.local/share/Trash"
  local size=$(du -sh "$TRASH" | cut -f1)
  rm -rf $TRASH/{files,info}/*
  echo "Cleared $size"
}

# Zoxide integration
eval "$(zoxide init bash)"

