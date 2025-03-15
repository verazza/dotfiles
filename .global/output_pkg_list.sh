pacman -Qeq > pacman_packages.txt

cd ~/.cache/yay/
find . -mindepth 2 -maxdepth 2 -type d -printf '%P\n' | sed 's/\/.*//' | sort > yay_packages.txt
mv yay_packages.txt ~/bash/
