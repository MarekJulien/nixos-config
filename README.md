
## Installation

#### Requirements

- Building the iso requires an existing NixOS machine

### Create and boot installer iso

1. Build an installer iso file by running `./installation/iso/build-iso.sh`
2. Flash the generated file (`./installation/iso/build/nixos-installer-[timestamp].iso`) to a CD or USB
3. Boot it on your device and click enter in every menu until you are prompted with a console

### Run the installation script on the target machine

1. Run `/etc/run-installer.sh` on the target machine

- This script will guide you through the rest of the installation and reboot automatically when completed
- You can remove the installation CD/USB after reboot and boot into the new installation

### Complete the installation

1. Run `sudo chown -R $USER:users ~/nixos-config`
2. Copy your `keys` directory to the new machine
