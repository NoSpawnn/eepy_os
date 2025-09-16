#!/usr/bin/env bash

# Replace ublue-os ujust with my own

set -ouex pipefail

NSOS_DIR=/usr/share/nsos
mkdir $NSOS_DIR

# Overwrite ujust to point to my global justfile
sed -i 's#/usr/share/ublue-os#/usr/share/nsos#' $(which ujust)
rm -r /usr/share/ublue-os

# Copy in custom justfiles
mkdir $NSOS_DIR/just
cp /ctx/justfiles/justfile $NSOS_DIR/justfile
cp /ctx/justfiles/*.just $NSOS_DIR/just/
