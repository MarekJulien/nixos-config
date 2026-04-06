#!/usr/bin/env bash
set -eux

##### FUNCTIONS #####
diskPart() {
   local part="$1"
   if [[ "$DISK" =~ [0-9]$ ]]; then
      echo "${DISK}p${part}"
   else
      echo "${DISK}${part}"
   fi
}

##### SCRIPT #####

##### Check for root #####
if [[ $EUID -ne 0 ]]; then
   echo "Please run as root"
   exit 1
fi

##### Get user inputs #####
# Select drive
echo "Available drives:"
lsblk -o TYPE,NAME,SIZE,LABEL,MOUNTPOINTS
read -p "Select drive (e.g. /dev/sda) - ALL DATA WILL BE LOST: " DISK
# Select FDE
read -p "Do you want to enable full disk encryption? (y/n): " USE_FDE
# Select flake configuration
read -p "Select flake configuration (e.g. laptop): " FLAKE_CONFIG
# Select main user
read -p "Select main user (e.g. beaver): " MAIN_USER

##### Set other variables #####
SWAPSIZE_GB=8
FLAKE_PATH="/home/nixos/nixos-config/nixos" # TODO dynamic
REBOOT_DELAY=5

##### Format disk #####
# Create GPT partition table
parted $DISK -- mklabel gpt
# Create & format boot partition
parted $DISK -- mkpart ESP fat32 1MB 512MB
parted $DISK -- set 1 esp on
mkfs.fat -F 32 -n boot $(diskPart 1)
# Full disk encryption
if [[ "$USE_FDE" =~ ^(y|Y|yes|YES)$ ]]; then
   echo "Full disk encryption ENABLED"
   sleep 3
   # create an encrypted partition
   parted $DISK -- mkpart primary 512MB 100%
   cryptsetup luksFormat -y --label="nixos-encrypted" $(diskPart 2)
   # open & map the encrypted partition to /dev/mapper/cryptroot
   cryptsetup luksOpen $(diskPart 2) cryptroot
   # create physical volume
   pvcreate /dev/mapper/cryptroot
   # create volume group
   vgcreate lvmroot /dev/mapper/cryptroot
   # create swap & format volume
   lvcreate --size ${SWAPSIZE_GB}G lvmroot --name swap
   mkswap -L "swap" /dev/mapper/lvmroot-swap
   # create & format root volume
   lvcreate -l 100%FREE lvmroot --name nixos
   mkfs.ext4 -L "nixos" /dev/mapper/lvmroot-nixos
else
   echo "Full disk encryption DISABLED"
   sleep 3
   # Create & format root partition
   parted $DISK -- mkpart root ext4 512MB -${SWAPSIZE_GB}GB
   mkfs.ext4 -L nixos $(diskPart 2)
   # Create & format swap partition
   parted $DISK -- mkpart swap linux-swap -${SWAPSIZE_GB}GB 100%
   mkswap -L swap $(diskPart 3)
fi
udevadm trigger
udevadm settle

##### Mount filesystems for installation #####
mount /dev/disk/by-label/nixos /mnt
mkdir -p /mnt/boot
mount -o umask=077 /dev/disk/by-label/boot /mnt/boot

##### Install nixos #####
nixos-install --no-root-passwd --flake "${FLAKE_PATH}#${FLAKE_CONFIG}"

##### Copy config repo #####
cp -r /home/nixos/nixos-config /mnt/home/${MAIN_USER}/

##### Link dotfiles #####
HOME="/home/${MAIN_USER}"
/mnt/home/$MAIN_USER/nixos-config/link-dotfiles.sh

##### Set main user password #####
nixos-enter --root /mnt -c "passwd ${MAIN_USER}"

##### Reboot #####
read -p "Installation complete. Press ENTER to reboot"
reboot 
