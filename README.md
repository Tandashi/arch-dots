# Arch Linux Dotfiles

# Installation
## Dependencies
- sxhkd
- dmenu
- kitty
- feh
- polybar
- picom-tryone-git
- python-dbus (used for polybar spotify module)
- dunst
- pulseaudio
- glava
- zsh
- anitbody
- spicetify

### Fonts
- Font Awesome 5 Free
- Fira Code (Nerd Font patched)

Glava install:
```
glava --copy-config
```
Then overwrite the config with repo once

Using Teamspeak and Spotify at same time. Could be that teamspeak3 mutes spotify if so comment out the following in `/etc/pulse/default.pa`:
```
load-module module-role-cork
```



## Hardware Information
- Windows 10 installation is on `sdd1`
- Windows "Boot loader" on `sda1`
- LAN only no wireless needed



## What I use for what
- Terminal Emulator: kitty
- Display Server: xorg
- Display Manager: lightdm
- Greeter: lightdm-webkit2-greeter
- Desktop Enviroment: bspwm



## How I installed Arch (EFI)
### General
```bash
loadkeys de
timedatectl set-ntp true
```

### Disks
sda1: Windows 10 Reserved things  
sda2 (primary): Boot Arch (512M)  
sda3 (primary, Linux Swap): Swap Arch (4GB)  
sda4 (pirmary): Files Arch (rest)  

Creating the partions and formating them:
```bash
cfdisk /dev/sda

mkfs.ext4 /dev/sda2
mkfs.ext4 /dev/sda4
mkswap /dev/sda3
swapon /dev/sda3
```

### Arch installation
```bash
mount /dev/sda4 /mnt
pacstrap /mnt base linux linux-firmware nano
genfstab /mnt >> /mnt/etc/fstab

arch-chroot /mnt
ln -sf /usr/share/zoneinfo/Europe/Berlin /etc/localtime
hwclock --systohc
nano /etc/locale.gen
locale-gen
echo "LANG=en_GB.UTF-8" >> /etc/locale.conf
echo "arch" >> /etc/hostname
```

Edit hosts (/etc/hosts):
```
127.0.0.1   localhost
::1         localhost
127.0.1.1   arch.localdomain  arch
```

```bash
passwd
pacman -S grub networkmanager dunst os-prober mtools dosfstools base-devel linux-headers ntfs-3g
grub-install --target=i386-pc /dev/sda
mkdir /mnt/windows10 # Dir to mount windows 10
mount /dev/sdd1 /mnt/windows10
grub-mkconfig -o /boot/grub/grub.cfg # Create grub boot config
exit
umount -a
reboot
```

### Setup Arch
```bash
loadkeys de # To load german keyboard layout
localectl set-keymap de # To persist german keyboard layout

# Enable Network
systemctl start NetworkManager
systemctl enable NetworkManager

# Create new User
useradd -m -G wheel tandashi # Create new user
passwd tandashi # Change users password
EDITOR=nano visudo # uncomment # %wheel ALL=(ALL) ALL

# Drivers and Display Server + Display Manager
pacman -S nvidia nvidia-utils # Install Nvidia Graphics Drivers
pacman -S xorg xorg-xinit xorg-server lightdm
systemctl enable lightdm

# Install Yay
pacman -S git
cd /opt
git clone https://aur.aurchlinux.org/yay-git.git
chown tandashi:tandashi -R yay-git/
cd yay-git
su tandashi
makepkg -si

# Setup lightdm
yay -S lightdm-webkit2-greeter

# Install bspwm
yay -Sy bspwm-rounded-corners

# Install Audio stuff
pacman -S alsa-utils

# Install Utils
pacman -S zip unzip rxvt-unicode
```

