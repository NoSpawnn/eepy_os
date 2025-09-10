#!/usr/bin/env bash

set -euox pipefail

PACKAGES=(
    hyprland
    pipewire
    polkit-kde
    xdg-desktop-portal-hyprland
    xdg-desktop-portal-gtk
    kitty
    sddm
    dunst
)

dnf5 install -y --allowerasing \
    --setopt=install_weak_deps=False \
    "${PACKAGES[@]}"

systemctl enable sddm