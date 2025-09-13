#!/bin/bash

set -ouex pipefail

# Install packages

PACKAGES=(
    zsh
    tailscale
    fastfetch
    flatpak
)

dnf5 install -y --setopt=install_weak_deps=False ${PACKAGES[@]}

INSTALL_SCRIPTS=(
    eza.sh
    incus.sh
    ohmyposh.sh
    # ly/ly.sh
    hyprland.sh
)

for s in ${INSTALL_SCRIPTS[@]}; do
    bash /ctx/install/$s
done

# System config

SYSTEM_CONFIG_SCRIPTS=(
    nsos-just.sh
    flatpak-system-remote-setup.sh
)

for s in ${SYSTEM_CONFIG_SCRIPTS[@]}; do
    bash /ctx/system_config/$s
done

# systemd services

SYSTEM_UNITS=(
    tailscaled.service
)

for unit in ${SYSTEM_UNITS[@]}; do
    systemctl enable $unit
done

GLOBAL_UNITS=(
    add-user-flathub-remote.service
)

for unit in ${GLOBAL_UNITS[@]}; do
    if [[ -e /ctx/systemd/$unit ]]; then
        cp /ctx/systemd/$unit /etc/systemd/user/
    fi
    systemctl enable --global $unit
done
