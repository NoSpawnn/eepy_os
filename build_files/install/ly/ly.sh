#/usr/bin/env bash
# ly v1.1.1 requires zig 0.14.x

set -euox pipefail

BUILD_DEPS=(
    kernel-devel
    pam-devel
    libxcb-devel
)
RUNTIME_DEPS=(
    xorg-x11-xauth
    xorg-x11-server-common
    brightnessctl
)
TEMP=$(mktemp -d)
ZIG_DIR=$TEMP/zig
ZIG_CACHE_DIR=$ZIG_DIR/cache
zig=$ZIG_DIR/zig

mkdir $ZIG_DIR
mkdir $ZIG_CACHE_DIR
export ZIG_GLOBAL_CACHE_DIR=$ZIG_CACHE_DIR

dnf5 install -y --setopt=install_weak_deps=False ${BUILD_DEPS[@]} ${RUNTIME_DEPS[@]}

cd $TEMP

tar --strip-components=1 -xf /ctx/install/ly/zig.tar.xz --directory=$ZIG_DIR

git clone https://codeberg.org/fairyglade/ly.git --branch v1.1.2

cd ly
$zig version
$zig build
$zig build installexe -Dinit_system=systemd

cd -
rm -r $TEMP

unset ZIG_GLOBAL_CACHE_DIR
dnf5 remove -y ${BUILD_DEPS[@]}

# SELinux policy - https://codeberg.org/fairyglade/ly/issues/494
semanage fcontext -a -t xdm_exec_t "/usr/bin/ly"
restorecon -v /usr/bin/ly
restorecon -v /usr/sbin/ly

systemctl enable ly.service
systemctl disable getty@tty2.service