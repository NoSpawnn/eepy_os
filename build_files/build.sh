#!/bin/bash

set -euxo pipefail

UTILS_SH="/ctx/utils.sh"
source "$UTILS_SH"

# Install packages in the system
INSTALL=(
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
)
REMOVE=(
    vim-common vim-data vim-enhanced vim-filesystem vim-minimal # Nuke regular vim
    firefox firefox-langpacks
    nvtop # WE ARE AN AMD HOUSEHOLD
)

dnf5 update -y
dnf5 install -y --setopt=install_weak_deps=False ${INSTALL[@]}
dnf5 remove -y ${REMOVE[@]}

ln -sf /usr/bin/nvim /usr/bin/vim

# Run branding early on since os-release is overwritten,
# make sure the versions of things are right, mainly copr repos
bash /ctx/system_config/branding.sh

INSTALL_SCRIPTS=(
    eza.sh
    incus.sh
    # ly/ly.sh
    hyprland.sh
    amdgpu_top.sh
    fonts.sh
)

for s in ${INSTALL_SCRIPTS[@]}; do
    UTILS_SH="$UTILS_SH" bash /ctx/install/$s
done

# System config

# Remove the default system flathub remote
flatpak remote-delete --system flathub

SYSTEM_CONFIG_SCRIPTS=(
    eepy-just.sh
    flatpak-system-remote-setup.sh
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

# GLOBAL_UNITS=(
#     add-user-flathub-remote.service
# )

# for unit in ${GLOBAL_UNITS[@]}; do
#     if [[ -e /ctx/systemd/$unit ]]; then
#         cp /ctx/systemd/global/$unit /etc/systemd/user/
#     fi
#     systemctl enable --global $unit
# done
