#!/usr/bin/env bash

# As of Fedora 42, eza isn't in DNF repos, so install it manually

set -euxo pipefail

source $UTILS_SH

TEMP=$(mktemp -d)

get_file_from_github "eza-community/eza" "latest" "eza_x86_64-unknown-linux-gnu\.tar\.gz" "$TEMP/eza.tar.gz"
tar xvf $TEMP/eza.tar.gz --directory $TEMP
mv $TEMP/eza /usr/bin/eza

rm -r $TEMP
