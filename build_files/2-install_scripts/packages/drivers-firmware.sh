#!/usr/bin/env bash

set -euxo pipefail

PACKAGES=(
    amd-ucode-firmware
    amd-gpu-firmware
    btrfs-progs
    mesa-filesystem
    mesa-libEGL
    mesa-libGL
    mesa-libgbm
    # mesa-va-drivers
    # mesa-vulkan-drivers
    mesa-dri-drivers
    # mesa-vdpau-drivers
    # rocm-hip
    # rocm-opencl
    # rocm-clinfo
    # rocm-smi
)

dnf5 install -y ${PACKAGES[@]}
