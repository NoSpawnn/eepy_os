[group('Virtualisation')]
new-dev-vm IMAGE="prompt" NAME="prompt" ENTER="ssh":
    #!/usr/bin/env bash
    set -e

    source /usr/lib/ujust/ujust.sh
    IMAGES='
      fedora/42
      ubuntu/22.04
      ubuntu/24.04
    '

    if [ "{{ IMAGE }}" == "prompt" ]; then
      echo "Image for new VM: "
      IMAGE="images:$(Choose $IMAGES)"
    fi
    if [ "{{ NAME }}" == "prompt" ]; then
      echo -en "Name for new VM: "
      read NAME
    fi

    incus_launch="incus launch --vm -c security.secureboot=false $IMAGE $NAME"
    echo $incus_launch
    $incus_launch

    # If we aren't entering the VM, then we're done here
    if [ "{{ ENTER }}" == "no" ]; then
        exit
    fi

    # Wait for the VM to launch
    # Checking the status in `incus ls` doesn't work since VMs
    # immediately say they are running, we need to wait for
    # the actual agent to start
    while true; do
        incus exec $NAME /bin/true 2> /dev/null
        if [ $? -eq 0 ]; then
            break
        else
            sleep 2
        fi
    done

    if [ "{{ ENTER }}" == "ssh" ]; then
        # Requires ssh2incus running and listening on port 2222
        # TODO: make agent forwarding work with bitwarden ssh agent
        # From ssh2incus log: Only NAT mode is supported for proxies on VM instances
        # https://linuxcontainers.org/incus/docs/main/reference/devices_proxy/
        ssh -p 2222 -o StrictHostKeyChecking=no -o UserKnownHostsFile=/dev/null -o LogLevel=ERROR "$NAME+$USER@localhost"
    elif [ "{{ ENTER }}" == "shell"]; then
        incus shell $NAME
    fi
