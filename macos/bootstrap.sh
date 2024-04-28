echo "linking dotfiles..."

if [ -d $HOME/.config/yabai ]; then rm -r $HOME/.config/yabai; fi
ln -sfn $HOME/dotfiles/macos/yabai/ $HOME/.config/yabai

if [ -d $HOME/.config/skhd ]; then rm -r $HOME/.config/skhd; fi
ln -sfn $HOME/dotfiles/macos/skhd/ $HOME/.config/skhd

echo "All done!"
