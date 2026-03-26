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

alias cd="z"
alias ls="ls --color"
alias la="ls -a"


#if [[ ! -v BASH_COMPLETION_VERSINFO ]]; then
#  . "/nix/store/rdv67mff1y8i47bx85mdxw86fjmzq1sf-bash-completion-2.16.0/etc/profile.d/bash_completion.sh"
#fi

#if [[ :$SHELLOPTS: =~ :(vi|emacs): ]]; then
#  eval "$(/nix/store/46kjb1qsifn7n66r0g3dw9w29vc363zg-fzf-0.62.0/bin/fzf --bash)"
#fi

eval "$(zoxide init bash )"

