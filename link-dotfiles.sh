#!/usr/bin/env bash

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

find "$SCRIPT_DIR/dotfiles" -type f,l | while read file; do
	target="$HOME/${file#./dotfiles/}"
	mkdir -pv "$(dirname "$target")"
	ln -sfv "$(realpath "$file")" "$target"
done
