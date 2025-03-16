#!/bin/bash

export WINDOWS_USER=maeka

cd "$(dirname "$0")"

mkdir -p .global

wget https://github.com/equalsraf/win32yank/releases/download/v0.1.1/win32yank-x64.zip

unzip win32yank-x64.zip -d .global/win32yank-x64

rm win32yank-x64.zip

if [ ! -f /mnt/c/Users/$WINDOWS_USER/.wslconfig ]; then
  cat << EOF > /mnt/c/Users/maeka/.wslconfig
[wsl2]
kernelCommandLine = cgroup_no_v1=all
EOF
fi
