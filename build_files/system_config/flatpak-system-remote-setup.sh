#!/usr/bin/env bash

set -euox

flatpak remote-delete flathub
flatpak remote-add --if-not-exists --system flathub-system https://flathub.org/repo/flathub.flatpakrepo
