# wsl
cd ~

if [ ! -L /run/user/1000/wayland-0 ]; then
  if [ -d /mnt/wslg/runtime-dir ]; then
    ln -s /mnt/wslg/runtime-dir/wayland-0* /run/user/1000/
  else
    echo "Error: /mnt/wslg/runtime-dir not found."
  fi
fi

if [ ! -f $HOME/.inputrc ]; then
  echo 'set bell-style none' > ~/.inputrc
fi

