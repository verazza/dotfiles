# wsl
cd ~

me=$(whoami)

if [ ! -d "/run/user/1000/" ]; then
  sudo mkdir -p /run/user/1000/
  sudo chmod 700 /run/user/1000
  sudo chown -R "$me":"$me" /run/user/1000
  echo "\[$(date '+%Y-%m-%d %H:%M:%S')\] CREATED /run/user/1000/ FROM FIRST-SETUP" >>$HOME/.wsl.log
fi

if [ ! -L /run/user/1000/wayland-0 ]; then
  if [ -d /mnt/wslg/runtime-dir ]; then
    ln -s /mnt/wslg/runtime-dir/wayland-0* /run/user/1000/
    echo "\[$(date '+%Y-%m-%d %H:%M:%S')\] CREATED WAYLAND SYMLINK FROM BASHRC" >>$HOME/.wsl.log
  else
    echo "Error: /mnt/wslg/runtime-dir not found."
  fi
fi

# もし、$HOME/.win/wsl/.bashrcが存在すれば、そこを読み込む
if [ -f "$HOME/.win/wsl/.bashrc" ]; then
  . "$HOME/.win/wsl/.bashrc"
fi
