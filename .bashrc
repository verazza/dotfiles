#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

alias ls='ls --color=auto'
alias grep='grep --color=auto'
PS1='[\u@\h \W]\$ '
export PS1="\$ "

# starship
if command -v starship &> /dev/null; then
  eval "$(starship init bash)"
fi

# nvm
export NVM_DIR="$HOME/.nvm"
if [ -d "$NVM_DIR" ] && [ -s "$NVM_DIR/nvm.sh" ]; then
  . "$NVM_DIR/nvm.sh" # This loads nvm
fi
if [ -d "$NVM_DIR" ] && [ -s "$NVM_DIR/bash_completion" ]; then
  . "$NVM_DIR/bash_completion" # This loads nvm bash_completion
fi

# pyenv
export PYENV_ROOT="$HOME/.pyenv"
if [ -d "$PYENV_ROOT/bin" ]; then
  export PATH="$PYENV_ROOT/bin:$PATH"
  if command -v pyenv &> /dev/null; then
    eval "$(pyenv init --path)"
    eval "$(pyenv init -)"
    eval "$(pyenv virtualenv-init -)"
  fi
fi

# rustup
if [ -f "$HOME/.cargo/env" ]; then
  . "$HOME/.cargo/env"
fi

# scala
if [ -d "$HOME/.local/share/coursier/bin" ]; then
  export PATH="$PATH:$HOME/.local/share/coursier/bin"
fi

# sdkman
#THIS MUST BE AT THE END OF THE FILE FOR SDKMAN TO WORK!!!
export SDKMAN_DIR="$HOME/.sdkman"
if [ -d "$HOME/.sdkman" ] && [ -s "$HOME/.sdkman/bin/sdkman-init.sh" ]; then
  source "$HOME/.sdkman/bin/sdkman-init.sh"
fi

if [ -d "$HOME/.global/bin" ]; then
  export PATH="$PATH:$HOME/.global/bin"
fi

# arias
if command -v wl-copy &> /dev/null; then
  alias wl="wl-copy"
fi

# wsl
if [ -n "$WSL_DISTRO_NAME" ] && [ -f $HOME/.wsl/.bashrc ]; then
  source $HOME/.wsl/.bashrc
fi

