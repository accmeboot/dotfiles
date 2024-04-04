#! usr/bin/bash

if [ ! -d "plugins" ]; then
  mkdir plugins
  cd plugins
  git clone https://github.com/tmux-plugins/tpm
else
  echo "Plugins directory already exists"
fi

ln -s ~/.config/tmux/.tmux.conf ~/.tmux.conf
