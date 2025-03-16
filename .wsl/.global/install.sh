#!/bin/bash

cd "$(dirname "$0")"

wget https://github.com/equalsraf/win32yank/releases/download/v0.1.1/win32yank-x64.zip

unzip win32yank-x64.zip -d win32yank-x64

rm win32yank-x64.zip

