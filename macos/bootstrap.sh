#!/bin/bash

set -e

echo "linking dotfiles..."

if [ -d $HOME/.config/aerospace ]; then rm -r $HOME/.config/aerospace; fi
ln -sfn $HOME/dotfiles/macos/aerospace/ $HOME/.config/aerospace

echo "Installing dependencies..."
dependencies=(
  nvim
  tmux
  kitty
  yazi
  ffmpegthumbnailer
  unar
  jq
  poppler
  fd
  ripgrep
  fzf
  zoxide
  fastfetch
)
installed_formulas=$(brew list --formula)

for pkg in "${dependencies[@]}"; do
  if ! echo "$installed_formulas" | grep -q "$(basename "$pkg")\$"; then
    brew install $pkg
  else
    echo "$pkg is already installed"
  fi
done

echo "All done!"
