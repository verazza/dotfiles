#!/bin/bash

cd "$(dirname "$0")"
mkdir -p pkg
pacman -Qeq > pkg/pacman_pkgs.txt

find ~/.cache/yay/ -mindepth 2 -maxdepth 2 -type d -printf '%P\n' | sed 's/\/.*//' | sort > pkg/yay_pkgs.txt
 
