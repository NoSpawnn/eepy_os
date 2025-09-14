#!/bin/bash

set -ouex pipefail

# Install packages (a lot of these will eventually be moved to a distrobox I think)

INSTALL=(
    zsh
    tailscale
    fastfetch
    flatpak
    amd-ucode-firmware
    amd-gpu-firmware
    btrfs-progs
    neovim
    mesa-dri-drivers
    mesa-vdpau-drivers
    mesa-vulkan-drivers
    stow
    zsh-autosuggestions
    tldr
)
REMOVE=(
    vim-common vim-data vim-enhanced vim-filesystem vim-minimal # Nuke regular vim
    firefox firefox-langpacks
)

dnf5 install -y --setopt=install_weak_deps=False ${INSTALL[@]}
dnf5 remove -y ${REMOVE[@]}

ln -sf /usr/bin/nvim /usr/bin/vim

INSTALL_SCRIPTS=(
    eza.sh
    incus.sh
    ohmyposh.sh
    # ly/ly.sh
    hyprland.sh
    amdgpu_top.sh
    fonts.sh
)

for s in ${INSTALL_SCRIPTS[@]}; do
    bash /ctx/install/$s
done

# System config

SYSTEM_CONFIG_SCRIPTS=(
    nsos-just.sh
    flatpak-system-remote-setup.sh
    branding.sh
    udev/fancontrol.sh
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
    # add-user-flathub-remote.service
)

for unit in ${GLOBAL_UNITS[@]}; do
    if [[ -e /ctx/systemd/$unit ]]; then
        cp /ctx/systemd/$unit /etc/systemd/user/
    fi
    systemctl enable --global $unit
done
