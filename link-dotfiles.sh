#!/usr/bin/env bash

find ./dotfiles -type f | while read file; do
	target="$HOME/${file#./dotfiles/}"
	mkdir -pv "$(dirname "$target")"
	ln -sfv "$(realpath $file)" "$target"
done
