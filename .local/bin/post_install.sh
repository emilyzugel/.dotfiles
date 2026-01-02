#!/usr/bin/env bash
set -e

# ========================
# == VARIABLES ==
# ========================
AUR_HELPER="yay"
EDITOR="nvim"
DOTFILES_REPO="https://github.com/youruser/dotfiles.git"
CONFIG_DIR="$HOME/.config"

# ========================
# == FUNCTIONS ==
# ========================
msg() { echo -e "\n\033[1;32m[✔] $1\033[0m"; }

is_installed() {
  pacman -Qi "$1" &>/dev/null || $AUR_HELPER -Qi "$1" &>/dev/null
}

install_pkg() {
  local pkg="$1"
  if is_installed "$pkg"; then
    msg "$pkg already installed. Skipping."
  else
    msg "Installing $pkg..." &&
      $AUR_HELPER -S --needed --noconfirm "$pkg" &&
      msg "$pkg installed successfully!" ||
      msg "Failed to install $pkg."
  fi
}

# ========================
# == SYSTEM UPDATE ==
# ========================
msg "Updating system..."
sudo pacman -Syu --noconfirm &&
  $AUR_HELPER -Syu --noconfirm &&
  msg "System updated successfully!"

# ========================
# == AUR HELPER ==
# ========================
if ! command -v $AUR_HELPER >/dev/null 2>&1; then
  msg "Installing $AUR_HELPER..." &&
    git clone https://aur.archlinux.org/$AUR_HELPER.git /tmp/$AUR_HELPER &&
    cd /tmp/$AUR_HELPER &&
    makepkg -si --noconfirm &&
    cd - >/dev/null &&
    msg "$AUR_HELPER installed successfully!" ||
    msg "Failed to install $AUR_HELPER."
else
  msg "$AUR_HELPER already installed."
fi

# ========================
# == ESSENTIAL PACKAGES ==
# ========================
ESSENTIALS=(
  git neovim kitty wget curl unzip networkmanager waybar btop
  librewolf-bin wofi obsidian lazyvim proton
)

for pkg in "${ESSENTIALS[@]}"; do install_pkg "$pkg"; done

# ========================
# == FONTS ==
# ========================
install_pkg ttf-jetbrains-mono-nerd

# ========================
# == STARSHIP PROMPT ==
# ========================
install_pkg starship
msg "Starship prompt installed! (config will be loaded from your dotfiles)."

# ========================
# == KEYBOARD LAYOUTS ==
# ========================
LAYOUT_STATUS=$(localectl status | grep "Layout" | grep "us,br,kr" || true)
if [ -z "$LAYOUT_STATUS" ]; then
  msg "Configuring keyboard layouts..." &&
    sudo localectl set-x11-keymap us,br,kr pc105 "" grp:alt_shift_toggle &&
    msg "Keyboard layouts set (US default, BR and KR available)."
else
  msg "Keyboard layouts already configured."
fi

# ========================
# == AUDIO ==
# ========================
for pkg in pipewire pipewire-pulse pipewire-alsa wireplumber; do
  install_pkg "$pkg"
done

systemctl is-enabled --quiet pipewire ||
  (msg "Enabling Pipewire services..." &&
    sudo systemctl enable --now pipewire pipewire-pulse wireplumber &&
    msg "Pipewire enabled!") ||
  msg "Pipewire already active."

# ========================
# == VPN ==
# ========================
install_pkg proton-vpn

if ! protonvpn-cli s &>/dev/null; then
  msg "Initializing and connecting ProtonVPN..." &&
    sudo protonvpn-cli init &&
    sudo protonvpn-cli c -f &&
    msg "ProtonVPN connected successfully!" ||
    msg "ProtonVPN setup failed."
else
  msg "ProtonVPN already configured."
fi

# ========================
# == FIREWALL ==
# ========================
install_pkg ufw

if ! systemctl is-active --quiet ufw; then
  msg "Setting up UFW firewall rules..." &&
    sudo ufw reset &&
    sudo ufw default deny outgoing &&
    sudo ufw default deny incoming &&
    sudo ufw allow out 67/udp &&
    sudo ufw allow in 68/udp &&
    sudo ufw allow out on tun0 &&
    sudo ufw allow in on tun0 &&
    sudo ufw allow out 51820/udp && #protonvpn
    sudo ufw enable &&
    sudo systemctl enable --now ufw &&
    msg "Firewall active (VPN-only traffic allowed)." ||
    msg "Failed to configure UFW."
else
  msg "Firewall already active."
fi

# ========================
# == DOTFILES ==
# ========================
if [ -d "$CONFIG_DIR/.git" ]; then
  msg "Dotfiles already present. Pulling latest changes..." &&
    git -C "$CONFIG_DIR" pull &&
    msg "Dotfiles updated successfully." ||
    msg "Failed to update dotfiles."
else
  msg "Cloning dotfiles..." &&
    git clone "$DOTFILES_REPO" "$CONFIG_DIR" &&
    msg "Dotfiles cloned successfully." ||
    msg "Failed to clone dotfiles."
fi

# ========================
# == GIT + SSH + GPG CONFIG ==
# ========================
msg "Setting up Git configuration..."
read -rp "Enter your Git username: " GIT_NAME
read -rp "Enter your Git email: " GIT_EMAIL

git config --global user.name "$GIT_NAME" &&
  git config --global user.email "$GIT_EMAIL" &&
  git config --global core.editor "$EDITOR" &&
  msg "Git configuration applied."

# SSH setup
SSH_KEY="$HOME/.ssh/id_ed25519"
if [ ! -f "$SSH_KEY" ]; then
  msg "Generating new SSH key..." &&
    ssh-keygen -t ed25519 -C "$GIT_EMAIL" -f "$SSH_KEY" -N "" &&
    eval "$(ssh-agent -s)" &&
    ssh-add "$SSH_KEY" &&
    msg "SSH key generated and added." ||
    msg "Failed to generate SSH key."
else
  msg "SSH key already exists."
fi

echo "Your SSH public key (add it to GitHub):"
cat "$SSH_KEY.pub"

# GPG setup
read -rp "Do you want to create a new GPG key? (y/n): " CREATE_GPG
if [[ "$CREATE_GPG" == "y" ]]; then
  gpg --full-generate-key &&
    GPG_KEY_ID=$(gpg --list-secret-keys --keyid-format=long | grep sec | awk '{print $2}' | cut -d'/' -f2 | tail -n 1) &&
    git config --global user.signingkey "$GPG_KEY_ID" &&
    git config --global commit.gpgsign true &&
    msg "GPG key created and configured for Git."
else
  msg "Skipped GPG key creation."
fi

# ========================
# == VIRTUALBOX ==
# ========================
for pkg in virtualbox virtualbox-host-modules-arch; do install_pkg "$pkg"; done

systemctl is-active --quiet vboxdrv ||
  (sudo modprobe vboxdrv && msg "VirtualBox kernel module loaded.") ||
  msg "VirtualBox module already loaded."

# ========================
# == DONE ==
# ========================
msg "✅ System setup and maintenance complete! Safe to rerun anytime."

# ==OBS
# add install rofi, wlogout
# adicionar sudo pacman -S ttf-jetbrains-mono-nerd (yay nao funciona)
# adicionar yay -S openvpn dialog python-pip (depedencias proton-vpn-cli)
# instalar sudo pacman -S NetworkManager e configurar -->
# 	systemctl enable, status networkmanager--> ok
#
# AUDIO MIXER -- WIREMIX
# instalar hyprshot para screenshots
# wallpaper com swww
#	adicionar o deamon --> swww-daemon --format xrgb &
# 	--> sww img /home/zg/walls/japan-art.jpg --transition-type center --transition-fps 60 --transition-duration 1
# 	--> learn about: https://github.com/dylanaraps/pywal?tab=readme-ov-file (change color by bk img color)
#
#GITHUB CONFIG
#git config --global user.name "Your Name"
#git config --global user.email "your_email@example.com"
#git config --global --list
#ssh-keygen -t ed25519 -C "your_email@example.com"
#eval "$(ssh-agent -s)"
#ssh-add ~/.ssh/id_ed25519
# cat ~/.ssh/id_ed25519.pub --> Go to GitHub → Settings → SSH and GPG keys -> Click New SSH key -> Paste the key -> Save
# ssh -T git@github.com
# git status -> git add . -> git commit -m "Your message" -> git push
#
#INSTALL lsd --> yay -S lsd
#
# INSTALL LAZYVIM
# git clone https://github.com/LazyVim/starter ~/.config/nvim
# rm -rf ~/.config/nvim/.git
# ok
#
#PLUGIN COLORIZE LAZY VIM
#~/.config/nvim/lua/plugins/colorizer.lua
# adiciona dentro:
# return {
#   {
#     "NvChad/nvim-colorizer.lua",
#     event = { "BufReadPre", "BufNewFile" },
#     opts = {
#       filetypes = { "*" }, -- ativa em todos os tipos de arquivo
#       user_default_options = {
#         RGB = true,          -- #RGB
#         RRGGBB = true,       -- #RRGGBB
#         names = true,        -- nomes tipo "blue", "red"
#         RRGGBBAA = true,     -- #RRGGBBAA
#         rgb_fn = true,       -- rgb(), rgba()
#         hsl_fn = true,       -- hsl(), hsla()
#         css = true,          -- suporte a cores CSS
#         css_fn = true,
#         tailwind = true,     -- (opcional) suporte a cores Tailwind
#       },
#     },
#   },
# }

##CODE POST REQUEST PROGRAM --> posting (tui)
