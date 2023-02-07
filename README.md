# Hyprland Linux Configuration

### Dunst Notifications, Rofi Side Launcher
![image](https://user-images.githubusercontent.com/58751387/216806720-f36a74ff-6b08-4842-aa8c-7603c2430375.png)
### Transparent terminals with customized zsh prompt and extensions
![image](https://user-images.githubusercontent.com/58751387/216806870-e07a3b1b-e138-44fa-a9cf-197c783c7296.png)
### Rounded windows, floating windows and scratchpad available
![image](https://user-images.githubusercontent.com/58751387/216808036-bf6e57f9-a58f-429f-be80-ceb421f9ec79.png)


## Install
* Download and use the `Gnome Edition` Graphical Installer for Arch found [here](https://archlinuxgui.in/download.html)
* Use swap + hibernate
* Use btrfs file system (so you can take system snapshots!)

### Update
You may or may not need to run this if pacman updates aren't working
```bash
sudo find /var/cache/pacman/pkg/ -iname "*.part" -delete
sudo pacman -Syc
sudo pacman -Sy archlinux-keyring base-devel
sudo pacman-key --init
sudo pacman-key --delete 91FFE0700E80619CEB73235CA88E23E377514E00
sudo pacman-key --populate archlinux
sudo pacman -Syyyuuu
```

### Yay
Run as user NOT ROOT!
```
git clone https://aur.archlinux.org/yay-bin
cd yay-bin
makepkg -si
```

### Install Hyprland/Sway/Wayland Packages

``` bash
yay -S hyprland-bin polkit-gnome ffmpeg neovim viewnior       \
rofi pavucontrol thunar starship wl-clipboard wf-recorder     \
swaybg grimblast-git ffmpegthumbnailer tumbler playerctl      \
noise-suppression-for-voice thunar-archive-plugin kitty       \
waybar-hyprland wlogout swaylock-effects sddm-git pamixer     \
nwg-look-bin nordic-theme papirus-icon-theme dunst            \
hyprpicker-git noto-fonts noto-fonts-emoji                    \
noto-fonts-extra unicode-character-database                   \
xdg-desktop-portal-hyprland-git qt5-wayland qt6-wayland       \
ttf-font-awesome-5 otf-font-awesome swayidle
```

### Install Quality of Life Packages
```bash
yay -S base-devel vim git wget curl qemu-guest-agent zsh      \
bitwarden discord slack-desktop-wayland joplin-desktop        \
firefox zoom deja-dup dropbox nextcloud-client brave-bin      \
showmethekey teams-for-linux visual-studio-code-bin           \
docker docker-compose plex-media-player tree                  \
ttf-jetbrains-mono ttf-jetbrains-mono-nerd jetbrains-toolbox  \
pithos spotify plexamp-appimage rofi-emoji google-chrome      \
pianobar github-desktop-bin tlp tlpui zsh-theme-powerlevel10k \
ttf-meslo-nerd-font-powerlevel10k lolcat blueman bluez-utils  \
media-control-indicator-git mpris-proxy-service wdisplays     \
onedrivegui-git onedrive_tray-git metasploit postgresql nmap  \
wayvnc obs-studio v4l2loopback-dkms linux-headers wlrobs gimp \
burpsuite wl-clipboard-history-git wlsunset bpytop lf         \
inotify-tools terminator tmux thefuck downgrade remmina       \
timeshift timeshift-autosnap grub-btrfs  
```

### Copy these files
* Clone this repo
* Paste the folders in `dotconfig` in your own `~/.config` folder
* Copy over `~/.zshrc` to your home folder.
* Copy over `.p10k.zsh` to your home folder as well

### Autologin via SDDM
Paste this into `/etc/sddm.conf.d/autologin.conf` (you may have to make this directory)
```bash
[Autologin]
User=<username>
Session=hyprland
```
Then, add yourself to the autologin group with
```bash
sudo usermod -a -G autologin <username>
```

### Change browser
Use the following command, or if still in gnome, just open the settings app.
```bash
gnome-control-center
```
Use this (after installing Brave!) to set your default browser and pdf opener to Firefox instead of Brave.
Also, turn apps to dark mode. (IDEK if this actually does anything) 

### Installing oh-my-zsh
```bash
cd ~
git clone http://github.com/robbyrussell/oh-my-zsh ~/.oh-my-zsh
git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k
git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
```
Then set the theme in `.zshrc` if not done already. (This shouldn't be necessary if you used my `.zshrc`)
```bash
sed -i 's/_THEME=\"robbyrussel\"/_THEME=\"powerlevel10k/powerlevel10k\"/g' ~/.zshrc
```
Then change your default shell to ZSH
```bash
sudo usermod --shell /bin/zsh <username>
```

### Pianobar Driver
Change `/etc/libao.conf` to read
```bash
default_driver=pulse
```
instead of
```bash
default_driver=alsa
dev=default
```

### Turn on SDDM
```bash
sudo systemctl disable gdm && sudo systemctl enable sddm
```

### Desktop Portal (for screensharing)
Remove `xdg-desktop-portal-gnome` and `xdg-desktop-portal-gtk` and whichever other ones are installed, leaving only `xdg-desktop-portal` and `xdg-desktop-portal-hyprland`. These two will be started on boot by `~/.config/hypr/hyprland.conf`, no need to enable them via systemd.
```bash
yay -R xdg-desktop-portal-gnome xdg-desktop-portal-gtk
```

##### Downgrade `xdg-desktop-portal` to `1.14.6` (for now) 
Selecting windows to screen share is broken in the current version (as of Feb 5th, 2023)
```bash
sudo downgrade xdg-desktop-portal
```

### TimeShift BTRFS Shapshots and Automatic Grub Configuration
* Open TimeShift and configure it
* Take your first btrfs snapshot
* Run the alias `reinstallgrub` from the custom `.zshrc` file (if your system ever wont boot, the command this alias holds will fix it. You'll just have to chroot from a bootable usb first)

Follow [this guide for more info on how to set this up correctly](https://www.lorenzobettini.it/2022/07/timeshift-and-grub-btrfs-in-linux-arch/)

### Reboot
* Reboot
* Log into hyprland via SDDM

# Things to Know
### OBS Studio Screen Sharing
https://github.com/hw0lff/screen-share-sway

## Gotchas

- SDDM-GIT is required or you will run into shutdown bugs and delays
- Replace xdg-desktop-portal-wlr with **[xdg-desktop-portal-hyprland-git](https://wiki.hyprland.org/hyprland-wiki/pages/Useful-Utilities/Hyprland-desktop-portal/)**

## Work In Progress

- [ ] Better way to screenshare than OBS-Studio virtual camera (although, this isn't bad)
- [ ] ~~Snapshots in Grub menu~~
- [ ] WayVNC working in virtual workspace
- [X] Brave not steal all links. Basically, how do I set the default browser?
