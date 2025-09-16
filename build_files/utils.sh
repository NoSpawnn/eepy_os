#!/usr/bin/bash

set -euxo pipefail

# Prevent double sourcing
if [ "${_UTIL_SH_INCLUDED:-}" = "1" ]; then return; fi
_UTIL_SH_INCLUDED=1

if [ -f /ctx/.github_auth ]; then
    GITHUB_AUTH="-u $(cat /ctx/.github_auth)"
else
    GITHUB_AUTH=""
fi

get_file_from_github() {
    local repo="$1"
    local tag="$2"
    local file="$3"
    local OUTPUT="$4"

    local probe_url=""
    if [ "$tag" == "latest" ]; then
        probe_url="https://api.github.com/repos/$repo/releases/latest"
    else
        probe_url="https://api.github.com/repos/$repo/releases/tags/$tag"
    fi

    local final_url=$(curl -fLs $GITHUB_AUTH "$probe_url" \
                        | jq -r '.assets[].browser_download_url' \
                        | grep "$file")

    curl -fLs $GITHUB_AUTH "$final_url" -o $OUTPUT
}
