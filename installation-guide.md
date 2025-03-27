# Iso Download
> Go to Downloads section on archlinux.org, select your country mirror and download the .iso file.
# Archinstall
1. Connect to the wifi:
    > $ ip addr show (to check if you have an ip address)
    > $ iwctl (to log into iwclt prompt)
    [iwd]# > station wlan0 get-networks (to list all wifi networks available)
    [iwd]# > exit (to go back to normal prompt and connect the choosen wifi network)
    > $ iwctl --passphrase "your passphrase" station wlan0 connect "wi-fi name"
    > $ ip addr show (if there's an ip now, it means you're successfully connected)
    > $ ping -c 4 archlinux.org (opctional, but to make sure, you can ping to test the internet)
2. Switch to ssh
    > $ systemctl status sshd (it need to be running)
        ~ if ssh is not running you can try > $ systemctl start sshd
3. Set a root password
    > $ passwd
4. ARCH INSTALL
  > $ archinstall
        {
            "Language": "English",
            "Mirrors": "Your country mirror",
            "Locales": "your choosen keyboard layout",
            "Disk config":
                [
                    "Use a best-effort default partiotion layout",
                    "Select the harddrive you want to install arch",
                    "Filesystem": "ext4",
                    "Separeted /home partition";
                ],
            "Bootloader": "Systemd-boot",
            "Unified kernel images": "false",
            "Swap": "True",
            "Hostnmae": "archlinux",
            "Root password": "your root psswd",
            "User account": "your user name and psswd > set it as sudo",
            "Profile":
                [
                    "Type": "Desktop",
                    "Desktop": "awesomeWM",
                    "Greeteer": "ly",
                    "Graphics Driver": "AMD for me, choose yours :)";
                ],
            "Audio": "pulseaudio",
            "Kernels": "linux, lunux-lts", 
            "Additional packages": "",
            "Network config": "Use NetworkManager",
            "Timezone": "Press / to search, ex: Sao Paulo",
            "Time Sync (NTP)": "Enable";
        }
    > INSTALL
5. Reboot after installation (remove usb disk)
6. > $ sudo pacman -Sy ( connect to the wifi if it doesn't work :p )
        > $ nmcli dev wifi connect "your wifi" password "your password"
# Extra Packages
    > $ sudo pacman -S kitty firefox git neovim rofi picom base-devel
    > $ sudo pacman -S mesa vulkan-radeon pavucontrol (AMD Graphics)
    > $ sudo pacman -S lxappearence qt5ct qt5ct-themes-plugins (themes)
    > $ sudo git clone https://aur.archlinux.org/yay.git
        > $ cd yay
        > $ makepkg -si
    > $ sudo yay -S ttf-jetbrains-mono ttf-cascadia-code-nerd
        > $ fc-cache -fv
# Clone your .dotfiles
    > $ sudo git clone 
# THEMING
    * PICOM
        > sudo pacman -S picom
        > $ mkdir ~/.config/picom && cd ~/.config/picom
            > $ sudo nvim picom.conf
                ~Add:
                -->> opacity-rule = [
	                   "90:class_g = 'kitty'",
	                   "90:class_g = 'rofi'",
	                   "90:class_g = '.*'"
                     ];
                     backlight = true;
                     shadow = true; <<--
        > $ killall picom && picom --config ~/.config/picom/picom.conf --experimental-backends &
        > DONE :)
    
    * KITTY CATPPUCCIN:
        > $ sudo apt install kitty
        > $ sudo git clone https://github.com/catppuccin/kitty.git ~/.config/kitty/catppuccin
        > $ sudo nvim ~/.config/kitty/kitty.conf -- escreva:
            " allow_remote_control yes
            include ~/.config/kitty/catppuccin/themes/mocha.conf (confere se é isso memso)
       > DONE :)     "
    * ROFI CATPPUCCIN THEME
        > Clone https://github.com/catppuccin/rofi.git
            > mv the catppuccin.mocha.rasi and catppuccin.macchiato.rasi to /usr/share/rofi/themes
        > $ mkdir ~/.config/rofi && cd ~/.config/rofi
            > $ touch config.rasi (copy from catppuccin or clone from .dotfiles)
        > On ~/.config/rofi/config.rasi you can change width of the element and others...
        > Resume: it's taking the themes from /usr/share/rofi/themes and running the ~/.config/rofi/config.rasi file
        > In order to have transparency, add it directly to the color inside the choosen theme file.
        > DONE :)
    * LAZYVIM
        ~ Dependencies:
            > Nerfonts
            > $ sudo pacman -S tree-sitter-cli
        > $ mkdir ~/.config/nvim (if you don't have it yet)
        > $ mv ~/.config/nvim{,.bak}
        > $ sudo git clone https://github.com/LazyVim/starter ~/.config/nvim
        > $ sudo rm -rf ~/.config/nvim/.git
        > $ nvim
        > Sync and install all...
        > DONE :)
	
    * STARSHIP PROMPT
    	> $ sudo pacman -S starship
     	> Download the config starship.toml inside ~/.config
      	> $ sudo nvim ~/.bashrc --> and cat eval "$(starship init bash)" (For zsh: eval "$(starship init zsh)")
       > $ source ~/.bashrc
       > DONE :)
       
    * GTK & QT5CT THEMES
        > $ mkdir ~/.themes && mkdir ~/.icons
        > Go to gnome-look.org and install the icons and themes. Here are some I like:
                
        > For Catppuccin theme use yay:
            > $ yay -S catppuccin-gtk-theme-mocha catppuccin-gtk-theme-latte catppuccin-gtk-theme-macchiato catppuccin-gtk-theme-frappe
        > For qt5ct set:
            > To ~/.bashrc and ~/.profile: "export QT_QPA_PLATFORMTHEME=qt5ct"
            > To ~/.xinit: "export QT_QPA_PLATFORMTHEME=qt5ct" and "exec awesome"
            > to /etc/environment: "QT_QPA_PLATFORMTHEME=qt5ct"
	    
    * DARK READER > CATPPUCCCIN: https://github.com/catppuccin/dark-reader
