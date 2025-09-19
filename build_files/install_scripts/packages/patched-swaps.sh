#!/usr/bin/env bash

set -euxo pipefail

# Stealing patched binaries/stuff from ublue/bazzite
declare -A SWAPS=(
    ["copr:copr.fedorainfracloud.org:bazzite-org:bazzite"]="wireplumber"
    ["copr:copr.fedorainfracloud.org:bazzite-org:bazzite-multilib"]="pipewire bluez xorg-x11-server-Xwayland"
    ["copr:copr.fedorainfracloud.org:ublue-os:staging"]="fwupd"
)

for repo in "${!SWAPS[@]}"; do
    for package in ${SWAPS[$repo]}; do dnf5 -y swap --repo=$repo $package $package; done;
done
