#!/usr/bin/env bash

set -euxo pipefail

flatpak remote-add --if-not-exists --system flathub-system https://flathub.org/repo/flathub.flatpakrepo
