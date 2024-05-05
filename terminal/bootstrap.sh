#!/bin/bash

set -e

echo "linking dotfiles..."

if [ -d $HOME/.config/nvim ]; then rm -r $HOME/.config/nvim; fi
ln -sfn $HOME/dotfiles/terminal/nvim/ $HOME/.config/nvim

if [ -d $HOME/.config/tmux ]; then rm -rf $HOME/.config/tmux; fi
ln -sfn $HOME/dotfiles/terminal/tmux/ $HOME/.config/tmux

if [ -d $HOME/.config/kitty ]; then rm -r $HOME/.config/kitty; fi
ln -sfn $HOME/dotfiles/terminal/kitty/ $HOME/.config/kitty

if [ -d $HOME/.config/yazi ]; then rm -r $HOME/.config/yazi; fi
ln -sfn $HOME/dotfiles/terminal/yazi/ $HOME/.config/yazi

echo "Installng tmux plugin manager"
if [ ! -d "$HOME/dotfiles/terminal/tmux/plugins" ]; then
  mkdir $HOME/dotfiles/terminal/tmux/plugins
  git clone https://github.com/tmux-plugins/tpm $HOME/dotfiles/terminal/tmux/plugins
else
  echo "Plugins directory already exists"
fi


echo "Running the zsh configuration script in a new shell..."
bash $HOME/dotfiles/terminal/zsh/bootstrap.sh

echo "All done!"
