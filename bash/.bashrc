#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

eval "$(starship init bash)"

# ls --> lsd
alias ls='lsd -l'
alias l='lsd -a'
alias ll='lsd -la'
alias lt='lsd --tree'

alias grep='grep --color=auto'
alias nv='nvim'
alias cddot='cd ~/.config/'
alias cd.dot='cd ~/.dotfiles/'
alias bitcoin='~/.config/waybar/scripts/bitcoin_price.sh'
alias cdpj='cd ~/public/projects/'
alias bcalc="./public/projects/bcalc/bcalc.sh"
PS1='[\u@\h \W]\$ '

# Add local scripts locais to PATH
export PATH="$HOME/.local/bin:$PATH"
