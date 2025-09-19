#!/usr/bin/env bash

set -euxo pipefail

# Replace system `flathub` remote with `flathub-system`
# why is there no rename command? (there probably is and im just stupid)
flatpak remote-delete --system flathub
flatpak remote-add --if-not-exists --system flathub-system https://flathub.org/repo/flathub.flatpakrepo
