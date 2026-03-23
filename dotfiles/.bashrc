# Commands that should be applied only for interactive shells.
[[ $- == *i* ]] || return

export PS1='\[\e[92;1m\]\u\[\e[22;2;2m\]@\H\[\e[0m\]:\[\e[93;1m\]\w\[\e[0m\] \\$ '

HISTFILESIZE=100000
HISTSIZE=10000

shopt -s histappend
shopt -s checkwinsize
shopt -s extglob
shopt -s globstar
shopt -s checkjobs

alias copy='xclip -selection clipboard'


#if [[ ! -v BASH_COMPLETION_VERSINFO ]]; then
#  . "/nix/store/rdv67mff1y8i47bx85mdxw86fjmzq1sf-bash-completion-2.16.0/etc/profile.d/bash_completion.sh"
#fi

#if [[ :$SHELLOPTS: =~ :(vi|emacs): ]]; then
#  eval "$(/nix/store/46kjb1qsifn7n66r0g3dw9w29vc363zg-fzf-0.62.0/bin/fzf --bash)"
#fi

eval "$(zoxide init bash )"

