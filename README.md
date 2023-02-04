# Hyprland Linux Configuration

![Screenshot](https://github.com/ChrisTitusTech/hyprland-titus/raw/main/hyprland-titus.png)

## Install
* Use the Graphical Installer for Arch (Gnome one is fine)
* Use swap + hibernate
* Use btrfs file system

### Update
You may or may not need to run this if pacman updates aren't working
```bash
sudo find /var/cache/pacman/pkg/ -iname "*.part" -delete
sudo pacman -Syc
sudo pacman -Sy archlinux-keyring
sudo pacman-key --init
sudo pacman-key --delete 91FFE0700E80619CEB73235CA88E23E377514E00
sudo pacman-key --populate archlinux
```

### Yay

Run as user NOT ROOT!

```
# Before this you need base-devel installed
git clone https://aur.archlinux.org/yay-bin
cd yay-bin
makepkg -si
```

### Uninstall xdg-desktop-portal
Uninstall the version of `xdg-desktop-portal` you have installed by default. This could be `xdg-desktop-portal-wlr`, `xdg-desktop-portal-gnome`, or `xdg-desktop-portal-gtk`, among others.

### Powerlevel10k
git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k

### Packages

``` bash
yay -S hyprland-bin polkit-gnome ffmpeg neovim viewnior       \
rofi pavucontrol thunar starship wl-clipboard wf-recorder     \
swaybg grimblast-git ffmpegthumbnailer tumbler playerctl      \
noise-suppression-for-voice thunar-archive-plugin kitty       \
waybar-hyprland wlogout swaylock-effects sddm-git pamixer     \
nwg-look-bin nordic-theme papirus-icon-theme dunst            \
hyprpicker-git nono-fonts noto-fonts-emoji                    \
noto-fonts-extra unicode-character-database ttf-font-awesome-5\
xdg-desktop-portal-hyprland-git qt5-wayland qt6-wayland       \
hyprland-autoname-workspaces-git
```

### My Other Packages
```bash
yay -S base-devel vim git wget curl qemu-guest-agent zsh      \
bitwarden discord slack-desktop-wayland joplin-desktop        \
firefox brave deja-dup timeshift dropbox nextcloud-client     \
showmethekey teams-for-linux visual-studio-code-bin           \
oh-my-zsh-git  oh-my-zsh-plugin-syntax-highlighting           \
oh-my-zsh-plugin-autosuggestions docker docker-compose        \
ttf-jetbrains-mono ttf-jetbrains-mono-nerd jetbrains-toolbox  \
pithos spotify plexamp-appimage \
pianobar github-desktop-bin tlp tlpui zsh-theme-powerlevel10k \
ttf-meslo-nerd-font-powerlevel10k lolcat blueman bluez-utils  \
media-control-indicator-git mpris-proxy-service wdisplays zoom\
onedrivegui-git onedrive_tray-git metasploit postgresql nmap  \
wayvnc obs-studio v4l2loopback-dkms linux-headers lwrobs gimp \
burpsuite wl-clipboard-history-git wlsunset 
```
Installing oh-my-zsh
```bash
sh -c "$(wget -O- https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
```

# Autologin
Paste this into `/etc/sddm.conf.d/autologin.conf` (you may have to make this directory)
```bash
[Autologin]
User=<username>
Session=Hyprland
```
Then, add yourself to the autologin group with
```bash
sudo usermod -a -G autologin <username>
```
### OBS Studio Screen Sharing
https://github.com/hw0lff/screen-share-sway

## Gotchas

- SDDM-GIT is required or you will run into shutdown bugs and delays
- Replace xdg-desktop-portal-wlr with **[xdg-desktop-portal-hyprland-git](https://wiki.hyprland.org/hyprland-wiki/pages/Useful-Utilities/Hyprland-desktop-portal/)**

## Work In Progress

- [ ] Help Popup with Hotkey
- [ ] Wayland guide for nwg-look, wlr-randr, etc.
- [ ] Synergy Workaround - Looking at waynergy or just using KVM
- [ ] Gamescope Addition - Adding more parity with Steamdeck features
- [x] More Customizations for Waybar - Battery, Backlight, etc.
- [ ] Auto-configuration - Long term goal

## Sources used making these

- Official Hyprland Github <https://github.com/hyprwm/Hyprland>
- Linux Mobiles Hyprland dot files <https://github.com/linuxmobile/hyprland-dots>
