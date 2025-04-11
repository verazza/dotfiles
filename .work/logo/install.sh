#!/bin/bash

cd "$(dirname "$0")"

file_name="misaki_ttf_2021-05-05.zip"
wget "https://littlelimit.net/arc/misaki/${file_name}"
unzip "${file_name}"
rm misaki.txt misaki_gothic.ttf misaki_mincho.ttf readme.txt "${file_name}"
