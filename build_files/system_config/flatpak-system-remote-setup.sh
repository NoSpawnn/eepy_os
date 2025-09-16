#!/usr/bin/env bash

set -eux

flatpak remote-delete flathub
flatpak remote-add --if-not-exists --system flathub-system https://flathub.org/repo/flathub.flatpakrepo
