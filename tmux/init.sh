#! usr/bin/bash

if [ ! -d "~/dotfiles/tmux/plugins" ]; then
  mkdir ~/dotfiles/tmux/plugins
  git clone https://github.com/tmux-plugins/tpm ~/dotfiles/tmux/plugins
else
  echo "Plugins directory already exists"
fi

ln -s ~/dotfiles/tmux/.tmux.conf ~/.tmux.conf
