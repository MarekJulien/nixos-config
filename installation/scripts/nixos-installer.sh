#!/usr/bin/env bash
set -eux

##### Get user inputs #####
# Select drive
echo "Available drives:"
lsblk -o TYPE,NAME,SIZE,LABEL,MOUNTPOINTS
read -p "Select drive (e.g. /dev/sda) - ALL DATA WILL BE LOST: " DISK
# Select flake configuration
read -p "Select flake configuration (e.g. laptop): " FLAKE_CONFIG
# Select main user
read -p "Select main user (e.g. beaver): " MAIN_USER

##### Set other variables #####
FLAKE_PATH="/home/nixos/nixos-config/nixos/flake.nix" # TODO dynamic
REBOOT_DELAY=5

##### Use root #####
sudo -i

##### Format disk #####
# Create GPT partition table
parted $DISK -- mklabel gpt
# Create & format boot partition
parted $DISK -- mkpart ESP fat32 1MB 512MB
parted $DISK -- set 1 esp on
mkfs.fat -F 32 -n boot /dev/sda1
# Create & format root partition
parted $DISK -- mkpart root ext4 512MB -8GB
mkfs.ext4 -L nixos /dev/sda2
# Create & format swap partition
parted $DISK -- mkpart swap linux-swap -8GB 100%
mkswap -L swap /dev/sda3

##### Mount filesystems for installation #####
mount /dev/disk/by-label/nixos /mnt
mkdir -p /mnt/boot
mount -o umask=077 /dev/disk/by-label/boot /mnt/boot

##### Install nixos #####
nixos-install --flake "$FLAKE_PATH#$FLAKE_CONFIG"

##### Copy config repo #####
cp -r /home/nixos/nixos-config /mnt/home/$MAIN_USER/

##### Create empty keys directory #####
mkdir /mnt/home/$MAIN_USER/keys

##### Set main user password #####
nixos-enter --root /mnt -c "passwd $MAIN_USER"

##### Reboot #####
echo "Installation complete. Rebooting in $REBOOT_DELAY seconds"
sleep($REBOOT_DELAY)
reboot 


