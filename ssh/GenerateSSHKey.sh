#!/bin/zsh

user=$(whoami)
ssh -o BatchMode=yes -o StrictHostKeyChecking=no "$user@localhost"
keyPath="$HOME/.ssh/id_ecdsa"
if [ -f "$keyPath" ]; then
    echo "The ECDSA key already exists at $keyPath. Skipping key generation."
else
    echo "The ECDSA key does not exist. Generating a new key..."
    ssh-keygen -t ecdsa -f "$keyPath" -N ""
    echo "ECDSA key generated at $keyPath."
fi
