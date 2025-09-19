#!/usr/bin/env bash

COPRS_ENABLED=(
    "bazzite-org/bazzite"
    "bazzite-org/bazzite-multilib"
    "ublue-os/staging"
)

for copr in ${COPRS_ENABLED[@]}; do
    dnf5 -y copr enable "$copr"
    dnf5 -y config-manager setopt copr:copr.fedorainfracloud.org:${copr////:}.priority=98 ;
done
