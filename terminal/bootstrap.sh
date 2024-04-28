echo "linking dotfiles..."

if [ -d $HOME/.config/nvim ]; then rm -r $HOME/.config/nvim; fi
ln -sfn $HOME/dotfiles/terminal/nvim/ $HOME/.config/nvim


echo "Installng tmux plugin manager"
if [ ! -d "$HOME/dotfiles/terminal/tmux/plugins" ]; then
  mkdir $HOME/dotfiles/terminal/tmux/plugins
  git clone https://github.com/tmux-plugins/tpm $HOME/dotfiles/tmux/plugins
else
  echo "Plugins directory already exists"
fi

if [ -d $HOME/.tmux.conf ]; then rm -r $HOME/.tmux.conf; fi
ln -sfn $HOME/dotfiles/terminal/tmux/.tmux.conf $HOME/.tmux.conf

if [ -d $HOME/.config/kitty ]; then rm -r $HOME/.config/kitty; fi
ln -sfn $HOME/dotfiles/terminal/kitty/ $HOME/.config/kitty
