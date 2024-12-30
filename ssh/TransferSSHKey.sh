#!/bin/zsh

echo "Enter the target machine's IP address:"
read TARGET_IP
echo "Enter the target machine's username:"
read TARGET_USER
echo "Enter the target machine's OS (Linux/Windows):"
read OS_TYPE
if [[ "$OS_TYPE" == "Linux" ]]; then
    echo "Linux OS detected, using ssh-copy-id..."
    ssh-copy-id -i ~/.ssh/id_ecdsa.pub $TARGET_USER@$TARGET_IP
    echo "SSH key has been copied to the Linux machine."
elif [[ "$OS_TYPE" == "Windows" ]]; then
    echo "Windows OS detected, manually transferring the key..."
    REMOTE_SSH_DIR="C:/Users/"${TARGET_USER[1,5]}"/.ssh"
    REMOTE_AUTH_KEYS="$REMOTE_SSH_DIR/authorized_keys"
    ssh "$TARGET_USER@$TARGET_IP" "mkdir -p $REMOTE_SSH_DIR"
    scp ~/.ssh/id_ecdsa.pub "$TARGET_USER@$TARGET_IP:$REMOTE_AUTH_KEYS"
    echo "SSH key has been manually transferred to the Windows PC."
else
    echo "Unable to determine the OS or the OS is not supported."
fi
