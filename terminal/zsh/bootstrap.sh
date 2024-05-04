#!/bin/bash

set -e

echo "Creating ~/.zsh directory"
if [ ! -d "$HOME/.zsh" ]; then
  mkdir ~/.zsh
else
  echo "~/.zsh directory already exists"
fi

echo "Installing oh-my-zsh..."
RUNZSH=no sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" || exit

echo "Adding nv and kitten icat aliases  to ~/.zshrc"
echo "alias nv='nvim'" >> ~/.zshrc
echo "alias icat='kitten icat'" >> ~/.zshrc

echo "Changing ZSH_THEME to clean"
sed -i -e 's/ZSH_THEME=".*"/ZSH_THEME="clean"/' ~/.zshrc

echo "Cloning zsh-autosuggestions and zsh-syntax-highlighting"
git clone https://github.com/zsh-users/zsh-autosuggestions ~/.zsh/zsh-autosuggestions
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ~/.zsh/zsh-syntax-highlighting

echo "Source plugins in ~/.zshrc"
echo "source ~/.zsh/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh" >> ~/.zshrc
echo "source ~/.zsh/zsh-autosuggestions/zsh-autosuggestions.zsh" >> ~/.zshrc

echo "Adding fastfetch to ~/.zshrc"
echo "fastfetch --load-config $HOME/dotfiles/terminal/zsh/fastfetch-config.jsonc" >> ~/.zshrc

echo "Installing starship prompt"
RUNZSH=no curl -sS https://starship.rs/install.sh | sh

echo "Adding starship to ~/.zshrc"
echo 'eval "$(starship init zsh)"' >> ~/.zshrc

echo "Linking starhip.toml to ~/.config"
if [ -f $HOME/.config/starship.toml ]; then rm -r $HOME/.config/starship.toml; fi
ln -sfn $HOME/dotfiles/terminal/zsh/starship.toml $HOME/.config/starship.toml

echo "Zsh setup complete!"

