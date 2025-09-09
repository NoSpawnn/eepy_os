#!/bin/bash

# Replace ublue-os ujust with my own

set -ouex pipefail

NSOS_DIR=/usr/share/nsos

rm -r /usr/share/ublue-os
mkdir $NSOS_DIR

# Overwrite ujust to point to my global justfile
sed -i 's#ublue-os#nsos#' $(which ujust)

# Copy in custom justfiles
mkdir $NSOS_DIR/just
cp ./justfiles/justfile $NSOS_DIR/justfile
cp ./justfiles/*.just $NSOS_DIR/just/
