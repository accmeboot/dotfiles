#!/bin/bash

set -e

echo "linking dotfiles..."

if [ -d $HOME/.config/yabai ]; then rm -r $HOME/.config/yabai; fi
ln -sfn $HOME/dotfiles/macos/yabai/ $HOME/.config/yabai

if [ -d $HOME/.config/skhd ]; then rm -r $HOME/.config/skhd; fi
ln -sfn $HOME/dotfiles/macos/skhd/ $HOME/.config/skhd

echo "Installing dependencies..."
dependencies=(koekeishiya/formulae/yabai koekeishiya/formulae/skhd nvim tmux kitty yazi ffmpegthumbnailer unar jq poppler fd ripgrep fzf zoxide)
installed_formulas=$(brew list --formula)

for pkg in "${dependencies[@]}"; do
  if ! echo "$installed_formulas" | grep -q "$(basename "$pkg")\$"; then
    brew install $pkg
  else
    echo "$pkg is already installed"
  fi
done

echo "Enabling yabai..."
yabai --start-service

echo "Starting skhd..."
skhd --start-service

echo "All done!"
