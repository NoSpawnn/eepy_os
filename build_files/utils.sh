#!/usr/bin/env bash

set -euxo pipefail

# Prevent double sourcing
if [ "${_UTIL_SH_INCLUDED:-}" = "1" ]; then return; fi
_UTIL_SH_INCLUDED=1

# If the .github_auth file exists, that means we are (probably) building locally,
# and in testing rate limiting is a threat :sweat_smile:
# So use this to authenticate when making requests to (api.)github.com
# The file should be of the format `username:PAT`
if [ -f /ctx/.github_auth ]; then
    GITHUB_AUTH="-u $(cat /ctx/.github_auth)"
else
    GITHUB_AUTH=""
fi

#########################
### UTILITY FUNCTIONS ###
#########################

# get_file_from_github "USER/REPO" "TAG" "FILE" "OUTPUT_FILE"
# Download a file from a github release
# Arguments:
#   USER        - (string) Username of the github repository owner (e.g. "NoSpawnn")
#   REPO        - (string) Github repository name (e.g. "eepy_os")
#   TAG         - (string) Release tag, can be "latest" or a specific tag (e.g. "v1.2.0")
#   OUTPUT_FILE - (path)   Path to which the file will be saved
get_file_from_github() {
    local repo="$1"
    local tag="$2"
    local file="$3"
    local output_file="$4"

    local probe_url=""
    if [ "$tag" == "latest" ]; then
        probe_url="https://api.github.com/repos/$repo/releases/latest"
    else
        probe_url="https://api.github.com/repos/$repo/releases/tags/$tag"
    fi

    local final_url=$(curl -fLs $GITHUB_AUTH "$probe_url" \
                        | jq -r '.assets[].browser_download_url' \
                        | grep "$file")

    curl -fLs $GITHUB_AUTH "$final_url" -o $output_file
}
