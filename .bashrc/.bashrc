#
# ~/.bashrc
#
export QT_QPA_PLATFORMTHEME=qt5ct
export EDITOR=nvim

eval "$(starship init bash)"

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

alias ls='ls --color=auto'
alias grep='grep --color=auto'
alias ll='ls -la'
alias sudo='sudo -E'
alias nvim='sudo nvim'
alias yazi='sudo yazi'
alias dot='cd ~/.dotfiles'
PS1='[\u@\h \W]\$ '
