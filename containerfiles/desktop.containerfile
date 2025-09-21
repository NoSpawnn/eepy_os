# Allow build scripts to be referenced without being copied into the final image
FROM scratch AS ctx
COPY build_files /

# Base Image
FROM ghcr.io/ublue-os/base-main:latest

### Modifications

ENV UTILS_SH "/ctx/utils.sh"
ENV CLEAN_SH "/ctx/clean_and_commit.sh"
ENV SYSTEM_CONFIG_SH_DIR "/ctx/1-system_config"
ENV INSTALL_SCRIPTS_SH_DIR "/ctx/2-install_scripts"
ENV VARIANT "desktop"

COPY --from=ctx /1-system_config/files /

# System configuration
RUN --mount=type=bind,from=ctx,source=/,target=/ctx \
    --mount=type=cache,dst=/var/cache \
    --mount=type=cache,dst=/var/log \
    --mount=type=tmpfs,dst=/tmp \
    "$SYSTEM_CONFIG_SH_DIR/branding.sh" && \
    sh "$SYSTEM_CONFIG_SH_DIR/coprs.sh" --enable && \
    "$SYSTEM_CONFIG_SH_DIR/flatpak.sh" && \
    "$CLEAN_SH"

# Install drivers/firmware
RUN --mount=type=bind,from=ctx,source=/,target=/ctx \
    --mount=type=cache,dst=/var/cache \
    --mount=type=cache,dst=/var/log \
    --mount=type=tmpfs,dst=/tmp \
    "$INSTALL_SCRIPTS_SH_DIR/packages/drivers-firmware.sh" && \
    "$CLEAN_SH"

# Package installs/removals/swaps
RUN --mount=type=bind,from=ctx,source=/,target=/ctx \
    --mount=type=cache,dst=/var/cache \
    --mount=type=cache,dst=/var/log \
    --mount=type=tmpfs,dst=/tmp \
    "$INSTALL_SCRIPTS_SH_DIR/binaries/hyprland.sh" && \
    "$INSTALL_SCRIPTS_SH_DIR/binaries/amdgpu_top.sh" && \
    "$INSTALL_SCRIPTS_SH_DIR/binaries/eza.sh" && \
    "$INSTALL_SCRIPTS_SH_DIR/binaries/incus.sh" && \
    "$INSTALL_SCRIPTS_SH_DIR/packages/utilities.sh" && \
    "$INSTALL_SCRIPTS_SH_DIR/packages/patches-swaps.sh" && \
    "$INSTALL_SCRIPTS_SH_DIR/packages/uninstall.sh" && \
    "$CLEAN_SH"

# systemd services
RUN --mount=type=bind,from=ctx,source=/,target=/ctx \
    --mount=type=cache,dst=/var/cache \
    --mount=type=cache,dst=/var/log \
    --mount=type=tmpfs,dst=/tmp \
    "$SYSTEM_CONFIG_SH_DIR/systemd.sh" && \
    "$CLEAN_SH"

# Random tweaks/cleanups and finalizing build
#   - Disable earlier enabled coprs
#   - Remote toolbox.sh scripts
#   - Refresh font cache (fonts earlier copied into /usr/share/fonts)
RUN --mount=type=bind,from=ctx,source=/,target=/ctx \
    --mount=type=cache,dst=/var/cache \
    --mount=type=cache,dst=/var/log \
    --mount=type=tmpfs,dst=/tmp \
    sh "$SYSTEM_CONFIG_SH_DIR/coprs.sh" --disable && \
    rm -f /etc/profile.d/toolbox.sh && \
    fc-cache -fv &&\
    "$CLEAN_SH"

### LINTING
## Verify final image and contents are correct.
RUN bootc container lint
