#!/bin/bash

set -ouex pipefail

cd /ctx

# Install packages

INSTALL_SCRIPTS=(
    eza.sh
    incus.sh
    hyprland.sh
)

for s in ${INSTALL_SCRIPTS[@]}; do
    bash install/$s
done

# System config

SYSTEM_SCRIPTS=(
    nsos-just.sh
)

for s in ${SYSTEM_SCRIPTS[@]}; do
    bash system/$s
done
