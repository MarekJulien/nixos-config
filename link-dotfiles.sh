#!/usr/bin/env bash

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# Link repo dotfiles
echo "##### Link repo dotfiles #####"
find "$SCRIPT_DIR/dotfiles" -type f,l | while read file; do
	target="$HOME/${file#$SCRIPT_DIR/dotfiles/}"
	mkdir -pv "$(dirname "$target")"
	ln -sfv "$(realpath "$file")" "$target"
done

# Link ssh config
echo "##### Link ssh config #####"
ln -sfv "$HOME/keys/ssh/config" "$HOME/.ssh/config"
