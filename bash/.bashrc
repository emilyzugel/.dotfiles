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
alias cat='ccat'

alias grep='grep --color=auto'
alias nv='nvim'
alias cddot='cd ~/.config/'
alias cd.dot='cd ~/.dotfiles/'
alias bitcoin='~/.config/waybar/scripts/bitcoin_price.sh'
alias cdpj='cd ~/Projects/'
alias bcalc='./public/projects/bcalc/bcalc.sh'
alias cache='sudo pacman -Sc && paru -Sc'
# Video recording: wf-recorder
alias recordsa='wf-recorder -f ~/Videos/wf-recorder_$(date +%Y-%m-%d_%H-%M-%S).mp4 --audio=alsa_input.usb-Burr-Brown_from_TI_USB_Audio_CODEC-00.analog-stereo-input'
alias sshphone='~/.config/scripts/ssh_phone.sh'

PS1='[\u@\h \W]\$ '

# Add local scripts locais to PATH
export PATH="$HOME/.local/bin:$PATH"

# Warning for removing files
rm() {
  RED=$'\033[0;31m'
  RESET=$'\033[0m'

  echo
  read -rp "${RED}Delete from $(pwd)? [y/N] ${RESET}" answer

  if [[ "$answer" == "y" || "$answer" == "Y" ]]; then
    command rm "$@"
  else
    echo "Cancelled."
  fi
}
