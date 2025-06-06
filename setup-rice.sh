#!/bin/bash

echo "[*] Updating system..."
sudo pacman -Syu --noconfirm

echo "[*] Installing essential packages..."
sudo pacman -S --noconfirm \
  git xorg xorg-xinit \
  bspwm sxhkd alacritty polybar rofi picom \
  feh neovim unzip curl base-devel \
  ttf-font-awesome papirus-icon-theme

echo "[*] Installing eww (from AUR)..."
cd /tmp || exit
git clone https://aur.archlinux.org/eww.git
cd eww || exit
makepkg -si --noconfirm

echo "[*] Cloning dotfiles..."
cd ~ || exit
git clone https://github.com/heapbytes/dotfiles.git

echo "[*] Copying configs to ~/.config..."
mkdir -p ~/.config
cp -r dotfiles/* ~/.config/

echo "[*] Setting permissions..."
chmod +x ~/.config/bspwm/bspwmrc
chmod +x ~/.config/sxhkd/sxhkdrc

echo "[*] Writing .xinitrc..."
echo "exec bspwm" > ~/.xinitrc

echo "[*] Done. Run 'startx' to enter your new rice!"
