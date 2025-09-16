#/usr/bin/env bash
# https://docs.fedoraproject.org/en-US/quick-docs/fonts/

set -euxo pipefail

source $UTILS_SH

TEMP=$(mktemp -d)
FONT_DIR=/usr/share/fonts/0xproto

get_file_from_github "ryanoasis/nerd-fonts" "v3.4.0" "0xProto.zip" "$TEMP/0xproto.zip"
unzip $TEMP/0xproto.zip -d $TEMP

mkdir -p $FONT_DIR
cp $TEMP/*.ttf $FONT_DIR/
chown -R root: $FONT_DIR
chmod 644 $FONT_DIR/*
restorecon -vFr $FONT_DIR

rm -r $TEMP
fc-cache -fv
