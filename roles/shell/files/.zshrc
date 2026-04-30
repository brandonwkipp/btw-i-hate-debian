HISTFILE=$HOME/.zsh_history
HISTSIZE=1000
SAVEHIST=1000
setopt autocd
bindkey -e

zstyle :compinstall filename '$HOME/.zshrc'
autoload -Uz compinit
compinit

PS1='[%n@%m %~]$ '

eval "$(dircolors -b)"
alias ls="ls --color=auto"
alias grep="grep --color=auto"
alias diff="diff --color"

alias ansible-playbook="ansible-playbook --ask-become-pass"
alias dmesg="sudo dmesg"
alias history="history 0"
alias mount="sudo mount"
alias open="xdg-open"
alias umount="sudo umount -R"
alias view="vim -R"

# Local overrides and secrets — not managed by ansible
[ -f "$HOME/.zshrc.local" ] && source "$HOME/.zshrc.local"
