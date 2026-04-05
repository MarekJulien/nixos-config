#!/usr/bin/env bash
set -e

# Set vars
WORKING_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
TIMESTAMP=$(date +"%Y%m%d-%H%M")
OUTPUT_NAME="nixos-installer-$TIMESTAMP.iso"

# Build iso file
nix build "$WORKING_DIR"#nixosConfigurations.iso.config.system.build.isoImage \
  --out-link $WORKING_DIR/result

# Move and rename output file
mkdir -p $WORKING_DIR/build
cp $WORKING_DIR/result/iso/*.iso "$WORKING_DIR/build/$OUTPUT_NAME"
rm -rf $WORKING_DIR/result

echo "ISO created: $WORKING_DIR/$OUTPUT_NAME"