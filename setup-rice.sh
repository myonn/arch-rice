#!/bin/bash

echo "[*] Updating system..."
sudo pacman -Syu --noconfirm

echo "[*] Installing essential packages..."
sudo pacman -S --noconfirm \
  git xorg xorg-xinit \
  bspwm sxhkd alacritty polybar rofi picom \
  feh neovim unzip curl unzip \
  ttf-font-awesome papirus-icon-theme \
  base-devel

# Install EWW (from AUR)
echo "[*] Installing eww (from AUR)..."
cd /tmp || exit
git clone https://aur.archlinux.org/eww.git
cd eww || exit
makepkg -si --noconfirm

echo "[*] Cloning rice from heapbytes..."
cd ~ || exit
git clone https://github.com/heapbytes/dotfiles.git

echo "[*] Copying dotfiles to ~/.config..."
mkdir -p ~/.config
cp -r dotfiles/* ~/.config/

echo "[*] Setting execute permissions..."
chmod +x ~/.config/bspwm/bspwmrc
chmod +x ~/.config/sxhkd/sxhkdrc

echo "[*] Writing .xinitrc..."
echo "exec bspwm" > ~/.xinitrc

echo "[*] Setup complete. You can now run:"
echo "    startx"
