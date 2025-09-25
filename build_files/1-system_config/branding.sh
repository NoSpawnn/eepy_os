#!/usr/bin/env bash

# https://www.man7.org/linux/man-pages/man5/os-release.5.html

set -euxo pipefail

osrelease="/usr/lib/os-release"

NAME="eepy_OS"
PRETTY_NAME="eepy_OS"
ID="eepy_os"
ID_LIKE="fedora"
VERSION_ID="$(rpm -E %fedora)"
PLATFORM_ID="platform:f$VERSION_ID"
IMAGE_ID="eepy_os"
RELEASE_TYPE="stable"
DEFAULT_HOSTNAME="eepy"
VENDOR_NAME="NoSpawnn"
HOME_URL="https://github.com/NoSpawnn/eepy_os"
DOCUMENTATION_URL="https://github.com/NoSpawnn/eepy_os"
BUG_REPORT_URL="https://github.com/NoSpawnn/eepy_os/issues/"
SUPPORT_URL="https://github.com/NoSpawnn/eepy_os/issues/"
ANSI_COLOR="0;35"
VARIANT="Server"
VARIANT_ID="server"

sed -i -e "s|NAME=.*|NAME=${NAME}|" \
       -e "s|PRETTY_NAME=.*|PRETTY_NAME=${PRETTY_NAME}|" \
       -e "s|ID=.*|ID=${ID}|" \
       -e "s|VERSION_ID=.*|VERSION_ID=${VERSION_ID}|" \
       -e "s|PLATFORM_ID=.*|PLATFORM_ID=${PLATFORM_ID}|" \
       -e "s|DEFAULT_HOSTNAME=.*|DEFAULT_HOSTNAME=${DEFAULT_HOSTNAME}|" \
       -e "s|VENDOR_NAME=.*|VENDOR_NAME=${VENDOR_NAME}|" \
       -e "s|HOME_URL=.*|HOME_URL=${HOME_URL}|" \
       -e "s|DOCUMENTATION_URL=.*|DOCUMENTATION_URL=${DOCUMENTATION_URL}|" \
       -e "s|SUPPORT_URL=.*|SUPPORT_URL=${SUPPORT_URL}|" \
       -e "s|ANSI_COLOR=.*|ANSI_COLOR=\"${ANSI_COLOR}\"|" \
       /usr/lib/os-release

cat <<EOF >> /usr/lib/os-release
ID_LIKE=${ID_LIKE}
RELEASE_TYPE=${RELEASE_TYPE}
VARIANT=${VARIANT}
VARIANT_ID=${VARIANT_ID}
EOF
