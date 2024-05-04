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

echo "Installing powerlevel10k theme..."
git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k

echo "Linking powerlevel10k configuration to ~/.p10k.zsh"
if [ -d $HOME/.p10k.zsh ]; then rm -r $HOME/.p10k.zsh; fi
ln -sfn $HOME/dotfiles/terminal/zsh/.p10k.zsh $HOME/.p10k.zsh

echo "Adding powerlevel10k to ~/.zshrc"
echo "[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh" >> ~/.zshrc

echo "Changing ZSH_THEME to powerlevel10k"
sed -i -e 's/ZSH_THEME=".*"/ZSH_THEME="powerlevel10k/powerlevel10k"/' ~/.zshrc

echo "Cloning zsh-autosuggestions and zsh-syntax-highlighting"
git clone https://github.com/zsh-users/zsh-autosuggestions ~/.zsh/zsh-autosuggestions
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ~/.zsh/zsh-syntax-highlighting

echo "Source plugins in ~/.zshrc"
echo "source ~/.zsh/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh" >> ~/.zshrc
echo "source ~/.zsh/zsh-autosuggestions/zsh-autosuggestions.zsh" >> ~/.zshrc

echo "Adding Homer..."
echo "source $HOME/dotfiles/terminal/zsh/homer.sh" >> ~/.zshrc
