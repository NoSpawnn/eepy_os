# Install flatpaks from a file
[group('Config')]
[no-cd]
install-flatpaks LIST_FILE="" SCOPE="user":
    #!/usr/bin/env bash
    flatpaks=$(cat $(realpath {{ LIST_FILE }}) | tr '\n' ' ' )
    if [[ {{ SCOPE }} == 'user' ]]; then
        flatpak remote-add --if-not-exists --user flathub-user https://flathub.org/repo/flathub.flatpakrepo
    fi
    flatpak install -y --{{ SCOPE }} $flatpaks
