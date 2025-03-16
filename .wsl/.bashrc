# wsl
cd ~

export PATH="$HOME/.global/win32yank-x64:$PATH"

if [ ! -f $HOME/.inputrc ]; then
  echo 'set bell-style none' > ~/.inputrc
fi

