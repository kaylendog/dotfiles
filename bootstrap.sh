function prompt {
    read -p "$1 [$2]: " -r response
    if [ -z "$response" ]; then
        response=$2
    fi
    return $response
}

function confirm {
    return prompt "Continue (yes/no)?" "yes"
}

echo "Kaylen's Dotfiles - Bootstrap Setup"

DEVICE=$(prompt "Device" "/dev/sda")
BOOT_PARTITION_LABEL=$(prompt "Boot partition label" "NIXBOOT")
BOOT_PARTITION_SIZE=$(prompt "Boot partition size" "512M")
ROOT_PARTITION_LABEL=$(prompt "Root partition label" "NIXROOT")
ROOT_PARTITION_SIZE=$(prompt "Root partition size" "20G")

USE_SWAP=$(prompt "Use swap?" "yes")

if [ "$USE_SWAP" = "yes" ]; then
    SWAP_PARTITION_LABEL=$(prompt "Swap partition label" "NIXSWAP")
    SWAP_PARTITION_SIZE=$(prompt "Swap partition size" "8G")
fi

FILESYSTEM_TYPE=$(prompt "Filesystem type" "btrfs")

echo Using the following settings:
echo "Boot partition: $BOOT_PARTITION_LABEL ($BOOT_PARTITION_SIZE)"
echo "Root partition: $ROOT_PARTITION_LABEL"

if [ "$USE_SWAP" = "yes" ]; then
    echo "Swap partition: $SWAP_PARTITION_LABEL ($SWAP_PARTITION_SIZE)"
else
    echo "No swap partition"
fi

echo "Filesystem type: $FILESYSTEM_TYPE"

if [ "$(confirm)" != "yes" ]; then
    echo "Exiting"
    exit 1
fi

echo "Creating partitions"

fdisk $DEVICE <<EOF
g
n

+$BOOT_PARTITION_SIZE
n

+$ROOT_PARTITION_SIZE
t
1
1
t
2
20
w
EOF

if [ "$USE_SWAP" = "yes" ]; then
    fdisk $DEVICE <<EOF
n

+$SWAP_PARTITION_SIZE
t
3
19
w
EOF
fi

fdisk $DEVICE <<EOF
n

t
4
42
w
EOF

echo "Creating filesystems"

mkfs.fat -F32 "$DEVICE"1 -n $BOOT_PARTITION_LABEL

case $FILESYSTEM_TYPE in
btrfs)
    mkfs.btrfs -L $ROOT_PARTITION_LABEL "$DEVICE"2
    mount "$DEVICE"2 /mnt
    btrfs subvolume create /mnt/nixos
    umount /mnt
    mount -o subvol=nixos "$DEVICE"2 /mnt
    ;;
*)
    mkfs.ext4 -L $ROOT_PARTITION_LABEL "$DEVICE"2
    mount "$DEVICE"2 /mnt
    ;;
esac

if [ "$USE_SWAP" = "yes" ]; then
    mkswap -L $SWAP_PARTITION_LABEL "$DEVICE"3
    swapon "$DEVICE"3
fi

mkdir /mnt/boot

mount "$DEVICE"1 /mnt/boot

echo "Installing NixOS"

mkdir -p /mnt/root
git clone https://github.com/kaylendog/dotfiles /mnt/root/dotfiles
ln -s /mnt/root/dotfiles /mnt/etc/nixos

nixos-install

echo "Installation complete"
