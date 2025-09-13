#!/usr/bin/env bash

set -euox pipefail

PACKAGES=(
    hyprland
    pipewire
    polkit-kde
    xdg-desktop-portal-hyprland
    xdg-desktop-portal-gtk
    kitty
    dunst
    dolphin
    wofi
    waybar
    fontawesome-fonts-all
    swaylock-effects
    cascadia-code-nf-fonts
    cascadia-mono-nf-fonts
)

# Enable copr for swaylock-effects
dnf5 copr enable eddsalkield/swaylock-effects -y

dnf5 install -y --allowerasing \
    --setopt=install_weak_deps=False \
    "${PACKAGES[@]}"
