#!/usr/bin/env bash

NAME="nsos"
ID="nsos"
ID_LIKE="fedora"
PRETTY_NAME="NSOS"
osrelease="/usr/lib/os-release"

sed -i "s/NAME=.*/NAME=${NAME}/" $osrelease
sed -i "s/ID=.*/ID=${ID}/" $osrelease
sed -i "s/PRETTY_NAME=.*/PRETTY_NAME=${PRETTY_NAME}/" $osrelease
echo "ID_LIKE=${ID_LIKE}" >> $osrelease
