# Hyprland Linux Configuration

![Screenshot](https://github.com/ChrisTitusTech/hyprland-titus/raw/main/hyprland-titus.png)

## Install
* Use the Graphical Installer for Arch (Gnome one is fine)
* Use swap + hibernate
* Use ~~btrfs~~ ext4 file system

### Update
You may or may not need to run this if pacman updates aren't working
```bash
sudo find /var/cache/pacman/pkg/ -iname "*.part" -delete
sudo pacman -Syc
sudo pacman -Sy archlinux-keyring
sudo pacman-key --init
sudo pacman-key --delete 91FFE0700E80619CEB73235CA88E23E377514E00
sudo pacman-key --populate archlinux
sudo pacman -Syyyuuu
```

### Yay

Run as user NOT ROOT!

```
# Before this you need base-devel installed
git clone https://aur.archlinux.org/yay-bin
cd yay-bin
makepkg -si
```

### Packages

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
ttf-font-awesome-5 otf-font-awesome
```

### My Other Packages
```bash
yay -S base-devel vim git wget curl qemu-guest-agent zsh      \
bitwarden discord slack-desktop-wayland joplin-desktop        \
firefox zoom deja-dup dropbox nextcloud-client brave-bin      \
showmethekey teams-for-linux visual-studio-code-bin           \
docker docker-compose                                         \
ttf-jetbrains-mono ttf-jetbrains-mono-nerd jetbrains-toolbox  \
pithos spotify plexamp-appimage rofi-emoji google-chrome      \
pianobar github-desktop-bin tlp tlpui zsh-theme-powerlevel10k \
ttf-meslo-nerd-font-powerlevel10k lolcat blueman bluez-utils  \
media-control-indicator-git mpris-proxy-service wdisplays     \
onedrivegui-git onedrive_tray-git metasploit postgresql nmap  \
wayvnc obs-studio v4l2loopback-dkms linux-headers wlrobs gimp \
burpsuite wl-clipboard-history-git wlsunset bpytop lf         \
inotify-tools terminator tmux thefuck                         
```

### Copy these files
* Clone this repo
* Paste the folders in `dotconfig` in your own `~/.config` folder

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
```bash
gnome-control-center
```
Use this to set your default browser to Firefox instead of Brave.
Also, turn apps to dark mode. (IDEK if this actually does anything) 

### Installing oh-my-zsh
```bash
git clone http://github.com/robbyrussell/oh-my-zsh ~/.oh-my-zsh
git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k
git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
```
Then, replace your current `~/.zshrc` file with the one in this repo. 
Copy over `.p10k.zsh` to your home folder as well.
Then set the theme in `.zshrc` if not done already. (This shouldn't be necessary if you used my `.zshrc`)
```bash
sed -i 's/_THEME=\"robbyrussel\"/_THEME=\"powerlevel10k/powerlevel10k\"/g' ~/.zshrc
```
Then change your default shell to ZSH
```bash
sudo usermod --shell /bin/zsh <username>
```

### Turn on SDDM
```bash
sudo systemctl disable gdm && sudo systemctl enable sddm
```

### Reboot
* Reboot
* Log into hyprland via SDDM

# Things to Know
### OBS Studio Screen Sharing
https://github.com/hw0lff/screen-share-sway

~~### TimeShift BTRFS Shapshots and Automatic Grub Configuration~~
~~Follow [this guide](https://www.lorenzobettini.it/2022/07/timeshift-and-grub-btrfs-in-linux-arch/)~~

~~### Uninstall xdg-desktop-portal~~
~~Uninstall the version of `xdg-desktop-portal` you have installed by default. This could be `xdg-desktop-portal-wlr`, `xdg-desktop-portal-gnome`, or `xdg-desktop-portal-gtk`, among others.~~

## Gotchas

- SDDM-GIT is required or you will run into shutdown bugs and delays
- Replace xdg-desktop-portal-wlr with **[xdg-desktop-portal-hyprland-git](https://wiki.hyprland.org/hyprland-wiki/pages/Useful-Utilities/Hyprland-desktop-portal/)**

## Work In Progress

- [ ] Better way to screenshare than OBS-Studio virtual camera (although, this isn't bad)
- [ ] ~~Snapshots in Grub menu~~
- [ ] WayVNC working in virtual workspace
- [X] Brave not steal all links. Basically, how do I set the default browser?
