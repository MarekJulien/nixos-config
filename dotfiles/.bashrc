# Commands that should be applied only for interactive shells.
[[ $- == *i* ]] || return

export PS1='\[\e[92;1m\]\u\[\e[22;2;2m\]@\H\[\e[0m\]:\[\e[93;1m\]\w\[\e[0m\] \\$ '

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
alias clear-trash="rm -rf ~/.local/share/Trash/{files,info}/*"

# Functions
test-pkgs() {
  nix-shell --run bash -p "$@"
}

# Zoxide integration
eval "$(zoxide init bash)"

