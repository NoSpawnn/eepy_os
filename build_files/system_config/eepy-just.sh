#!/usr/bin/env bash

# Replace ublue-os ujust with my own

set -euxo pipefail

EEPYOS_DIR=/usr/share/eepy_os
mkdir $EEPYOS_DIR

# Overwrite ujust to point to my global justfile
sed -i 's#/usr/share/ublue-os#/usr/share/eepy_os#' $(which ujust)
# rm -r /usr/share/ublue-os Maybe?

# Copy in custom justfiles
mkdir $EEPYOS_DIR/just
cp /ctx/justfiles/justfile $EEPYOS_DIR/justfile
cp /ctx/justfiles/*.just $EEPYOS_DIR/just/
